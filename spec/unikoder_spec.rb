require "minitest/autorun"

require_relative "../lib/unikoder"

describe Unikoder do
  before do
    @unikoder = Unikoder.new
  end

  it "has an encode method" do
    @unikoder.encode("hello")
  end
  
  it "converts a single character into its equivalent space representation" do
    @unikoder.convert_character("H").must_equal [" ", " "]
    @unikoder.convert_character("\u2713").must_equal [" ", " ", " ", " ", " "]
  end
end