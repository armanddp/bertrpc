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
     
     # Ruby 1.9 Compatibility
     def read_int
       fail("Invalid Type, not an int") unless read_1 == INT
       value = read_4
       negative = (value >> 31)[0] == 1
       value = (value - (1 << 32)) if negative
       value.to_i
     end

     def read_small_bignum
       fail("Invalid Type, not a small bignum") unless read_1 == SMALL_BIGNUM
       size = read_1
       sign = read_1
       bytes = read_string(size).unpack("C" * size)
       added = bytes.zip((0..bytes.length).to_a).inject(0) do |result, byte_index|
         byte, index = *byte_index
         value = (byte * (256 ** index))
         sign != 0 ? (result - value) : (result + value)
       end
       added
     end

     def read_large_bignum
       fail("Invalid Type, not a large bignum") unless read_1 == LARGE_BIGNUM
       size = read_4
       sign = read_1
       bytes = read_string(size).unpack("C" * size)
       added = bytes.zip((0..bytes.length).to_a).inject(0) do |result, byte_index|
         byte, index = *byte_index
         value = (byte * (256 ** index))
         sign != 0 ? (result - value) : (result + value)
       end
       added
     end
  end
end