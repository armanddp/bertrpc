module ERPC
  class Request
    attr_accessor :from, :kind, :options

    def initialize(svc, kind, from, options)
      @svc = svc
      @kind = kind
      @from = from
      @options = options
    end

    def method_missing(cmd, *args)
      Mod.new(@svc, self, cmd)
    end
  end
end