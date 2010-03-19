module ERPC
  class Action < BERTRPC::Action

    def execute
      bert_request = encode_ruby_request(t[@req.kind, @req.from, @mod, @fun, @args])
      bert_response = transaction(bert_request)
      decode_bert_response(bert_response)
    end
  end
end
