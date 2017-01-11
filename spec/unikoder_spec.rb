require "minitest/autorun"

require_relative "../lib/unikoder"

describe Unikoder do
  before do
    @unikoder = Unikoder.new
  end

  it "has an encode method" do
    @unikoder.encode("hello")
  end
  
  it "encodes a single character into its equivalent space representation" do
    @unikoder.encode_character("H").must_equal [" ", " ", " "]
    @unikoder.encode_character("\u2713").must_equal [" ", " ", " ", " ", " ", " "]
  end
  
  it "encodes a string into its equivalent space representation" do
    @unikoder.encode_string("Hello World").must_equal [" ", " ", " ", " ", " ", " ", " ", 
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", 
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", 
      " "]
  end
end