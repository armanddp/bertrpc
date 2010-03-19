module ERPC
  module Decodes

    def decode_bert_response(bert_response)
      puts bert_response
      ruby_response = BERT.decode(bert_response)
      debugger
      case ruby_response[0]
        when :rpc_result
          ruby_response[2]
        when :error
          error(ruby_response[1])
        else
          raise
      end
    end
  end
end