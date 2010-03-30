module ERPC
  module Decodes

    def decode_bert_response(bert_response)
      debugger
      ruby_response = BERT.decode(bert_response)
      case ruby_response[0]
        when :rpc_result
          do_handle_rpc_result(ruby_response[2])
        when :error
          error(ruby_response[1])
        when :throw
          raise Error.new(ruby_response[1])
        else
          raise
      end
    end
    
    private
    # TODO: Remove interpretation code from here to do in higher-level
    def do_handle_rpc_result(response)
      case response[0]
        when :throw
          raise Error.new(format_error_message(response[1][1][1]))
        when :error
          raise Error.new(response[1])
        else
          raise NotSupportedError.new
      end
    end
    
    def format_error_message(message)
      message.to_s.gsub(/_/, ' ')
    end
  end
end