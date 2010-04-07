module ERPC
  class Binary < String
    def inspect
      "b[#{super}]"
    end
  end
end