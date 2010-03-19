module ERPC
  class Mod < BERTRPC::Mod

    def method_missing(cmd, *args)
      args = [*args]
      Action.new(@svc, @req, @mod, cmd, args).execute
    end
  end
end