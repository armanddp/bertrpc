module BERT
  class Decode
    def read_any_raw
      case peek_1
        when ATOM then read_atom
        when SMALL_INT then read_small_int
        when INT then read_int
        when SMALL_BIGNUM then read_small_bignum
        when LARGE_BIGNUM then read_large_bignum
        when FLOAT then read_float
        when SMALL_TUPLE then read_small_tuple
        when LARGE_TUPLE then read_large_tuple
        when NIL then read_nil
        when STRING then read_erl_string
        when LIST then read_list
        when BIN then read_bin
        else
          fail("Unknown term tag: #{peek_1}")
      end
    end
    
    def read_erl_string
      debugger
      fail("Invalid Type, not an erlang string") unless read_1 == STRING
      length = read_2
      read_string(length)
    end
     
    def read_tuple(arity)
       if arity > 0
         tag = read_any_raw || :undefined
         if tag == :bert
           read_complex_type(arity)
         else
           tuple = Tuple.new(arity)
           tuple[0] = tag
           (arity - 1).times { |i| tuple[i + 1] = read_any_raw }
           tuple
         end
       else
         Tuple.new
       end
     end
  end
end