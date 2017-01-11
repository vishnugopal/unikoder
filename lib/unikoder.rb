require "forgery"

class Unikoder
  UnikoderInvalidInput = StandardError.new

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
  
  def decode(corpus)
    decode_string(corpus.scan(/#{STRING_STEGANOGRAPHY}/))
  end
  
  private
  
  def encode_character(character)
    character.ord.to_s(STRING_STEGANOGRAPHY.length - 1).chars.map { |digit|
      STRING_STEGANOGRAPHY[digit.to_i]
    } << STRING_STEGANOGRAPHY.last
  end
  
  def encode_string(string)
    string.chars.inject([]) do |encoded_string, character|
      encoded_string << encode_character(character)
    end.flatten
  end
  
  def decode_character(spaces_array)
    raise UnikoderInvalidInput unless spaces_array.is_a? Array
    
    character_ordinal = spaces_array.map do |space|
      STRING_STEGANOGRAPHY.index(space).to_s
    end.join
    
    unicode_point = character_ordinal.to_i.
      to_s(STRING_STEGANOGRAPHY.length - 1).to_i.to_s(16)
      
    # Trickery, because string interpolation doesn't work with the unicode \u{codepoint} syntax
    eval ("\"\\u{" + "#{unicode_point}" + "}\"")
  end
  
  def decode_string(space_array)
    raise UnikoderInvalidInput unless 
      space_array.last == STRING_STEGANOGRAPHY.last
    
    character_strings = space_array.join.split(STRING_STEGANOGRAPHY.last)
    
    character_arrays = character_strings.map do |character|
      character.chars
    end
    
    decoded_characters = character_arrays.map do |character_array|
      decode_character(character_array)
    end
    
    decoded_characters.join
  end
end