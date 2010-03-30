# Overrides the default BERT encoding to support ERPC specific encoding / decoding
module BERT
  class Encode
    def write_any_raw obj
      case obj
        when Symbol then write_symbol(obj)
        when Fixnum, Bignum then write_fixnum(obj)
        when Float then write_float(obj)
        when Tuple then write_tuple(obj)
        when Array then write_list(obj)
        when String then write_string_list(obj)
        else
          fail(obj)
      end
    end
    
    def write_string_list(data)
      fail(data) unless data.is_a? String
      #write_1 NIL and return if data.empty?
      write_1 STRING
      write_2 data.length
      write_string data
    end
  end
end