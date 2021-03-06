require "minitest/autorun"

require_relative "../lib/unikoder"

describe Unikoder do
  before do
    @unikoder = Unikoder.new
    Unikoder.send(:public, *Unikoder.private_instance_methods)
  end
  
  it "encodes a single character into its equivalent space representation" do
    @unikoder.encode_character("H").must_equal [" ", " ", " "]
    @unikoder.encode_character("\u2713").must_equal [" ", " ", " ", " ", " ", " "]
  end
  
  it "encodes a string into its equivalent space representation" do
    @unikoder.encode_string("Hello World").must_equal [" ", " ", " ", " ", " ", " ", " ", 
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", 
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  it "encodes messages by replacing spaces with appropriate unicode spaces" do
    @unikoder.encode("hello").must_equal "lorem ipsum dolor sit amet consectetuer \
adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit \
non interdum in"
    @unikoder.encode("hello world").must_equal "lorem ipsum dolor sit amet consectetuer \
adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit \
non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices \
posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui"
    @unikoder.encode("Check\u2713").must_equal "lorem ipsum dolor sit amet consectetuer \
adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non \
interdum in ante vestibulum ante ipsum"
  end
  
  it "decodes a spaces string array into an appropriate character" do
    @unikoder.decode_character([" ", " "]).must_equal "H"
    @unikoder.decode_character([" ", " ", " ", " ", " "]).must_equal "\u2713"
  end
  
  it "decodes a spaces string array into a message" do
    @unikoder.decode_string([" ", " ", " ", " ", " ", " ", " ", 
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", 
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "]).
        must_equal("Hello World")
  end
  
  it "can decode a message from a corpus" do
    @unikoder.decode("lorem ipsum dolor sit amet consectetuer \
adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit \
non interdum in").must_equal("hello")
    @unikoder.decode("lorem ipsum dolor sit amet consectetuer \
adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit \
non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices \
posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui").
      must_equal("hello world")
    @unikoder.decode("lorem ipsum dolor sit amet consectetuer \
adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non \
interdum in ante vestibulum ante ipsum").must_equal("Check✓")
  end
end