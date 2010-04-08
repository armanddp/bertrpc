require File.expand_path("lib/bertrpc.rb")

debugger

encoded = BERT::Encode.encode([b("0825559629")])

puts encoded