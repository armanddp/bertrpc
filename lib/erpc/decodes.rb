module ERPC
  module Decodes

    def decode_bert_response(bert_response)
      ruby_response = BERT.decode(bert_response)
      case ruby_response[0]
        when :rpc_reply
          ruby_response[1]
        else
          raise
      end
    end
  end
end