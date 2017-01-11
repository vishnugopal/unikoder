require "forgery"

class Unikoder
  STRING_STEGANOGRAPHY = [
    "\u2000", "\u2001", "\u2002", "\u2003", "\u2004", 
    "\u2005", "\u2006", "\u2007", "\u2008", "\u2009", 
    "\u205F"
  ]

  def encode(string, corpus: nil)
    encoded_spaces = encode_string(string)
    corpus = corpus || Forgery(:lorem_ipsum).words(encoded_spaces.length + 1)
    corpus_split_by_spaces = corpus.split(/\s/)
    
    encoded_array = []
    corpus_split_by_spaces.each_with_index do |corpus_word, index|
      encoded_array << corpus_word
      encoded_array << encoded_spaces[index] if index < encoded_spaces.length
    end
    
    encoded_array.join
  end
  
  def encode_character(character)
    character.ord.to_s(9).chars.map { |digit|
      STRING_STEGANOGRAPHY[digit.to_i]
    } << STRING_STEGANOGRAPHY.last
  end
  
  def encode_string(string)
    string.chars.inject([]) do |encoded_string, character|
      encoded_string << encode_character(character)
    end.flatten
  end
end