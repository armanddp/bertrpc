module BERTRPC
  class Action
    include Encodes

    def initialize(svc, req, mod, fun, args)
      @svc = svc
      @req = req
      @mod = mod
      @fun = fun
      @args = args
    end

    def execute
      bert_request = encode_ruby_request(t[@req.kind, @mod, @fun, @args])
      bert_response = transaction(bert_request)
      decode_bert_response(bert_response)
    end

    #private

    def write(sock, bert)
      bert.force_encoding "BINARY"
      sock.write([bert.bytesize].pack("N"))
      sock.write(bert)
    end

    def read(sock, len, timeout)
      data, size = [], 0
      while size < len
        r, w, e = IO.select([sock], [], [], timeout)
        raise Errno::EAGAIN if r.nil?
        msg, sender = sock.recvfrom(len - size)
        raise Errno::ECONNRESET if msg.size == 0
        size += msg.size
        data << msg
      end
      data.join ''
    end

    def transaction(bert_request)
      timeout = @svc.timeout && Float(@svc.timeout)
      sock = connect_to(@svc.host, @svc.port, timeout)
      if @req.options
        if @req.options[:cache] && @req.options[:cache][0] == :validation
          token = @req.options[:cache][1]
          info_bert = encode_ruby_request([:info, :cache, [:validation, token]])
          write(sock, info_bert)
        end
      end

      write(sock, bert_request)
      lenheader = read(sock, 4, timeout)
      raise ProtocolError.new(ProtocolError::NO_HEADER) unless lenheader
      len = lenheader.unpack('N').first
      bert_response = read(sock, len, timeout)
      raise ProtocolError.new(ProtocolError::NO_DATA) unless bert_response
      sock.close
      bert_response
    rescue Errno::ECONNREFUSED
      raise ConnectionError.new(@svc.host, @svc.port)
    rescue Errno::EAGAIN
      raise ReadTimeoutError.new(@svc.host, @svc.port, @svc.timeout)
    rescue Errno::ECONNRESET
      raise ReadError.new(@svc.host, @svc.port)
    end

    # Creates a socket object which does speedy, non-blocking reads
    # and can perform reliable read timeouts.
    #
    # Raises Timeout::Error on timeout.
    #
    #   +host+ String address of the target TCP server
    #   +port+ Integer port of the target TCP server
    #   +timeout+ Optional Integer (in seconds) of the read timeout
    def connect_to(host, port, timeout = nil)
      addr = Socket.getaddrinfo(host, nil, Socket::AF_INET)
      sock = Socket.new(Socket.const_get(addr[0][0]), Socket::SOCK_STREAM, 0)
      sock.setsockopt Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1

      if timeout
        secs = Integer(timeout)
        usecs = Integer((timeout - secs) * 1_000_000)
        optval = [secs, usecs].pack("l_2")
        begin
          sock.setsockopt Socket::SOL_SOCKET, Socket::SO_RCVTIMEO, optval
          sock.setsockopt Socket::SOL_SOCKET, Socket::SO_SNDTIMEO, optval
       rescue Exception => ex
         # Solaris, for one, does not like/support socket timeouts.
         @logger.info "[bertrpc] Unable to use raw socket timeouts: #{ex.class.name}: #{ex.message}" if @logger
       end
      end

      sock.connect(Socket.pack_sockaddr_in(port, addr[0][3]))
      sock
    end
  end
end
