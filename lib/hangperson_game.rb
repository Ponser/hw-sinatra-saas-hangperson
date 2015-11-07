class HangpersonGame
  
  # Looks good 151107:2018 UTC

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def dump # This is just for debugging and never should be called in a released version
    ', guesses = ' + @guesses + ', wrong_guesses = ' + @wrong_guesses
  end
  
  def guess(letter)
    # /[[:alpha:]]/ matches a letter of the alphabet.
    # See http://stackoverflow.com/questions/14551256/how-to-find-out-in-ruby-if-a-character-is-a-letter-or-a-digit
    throw ArgumentError if !letter || (1 != letter.length) || 0 != (/[[:alpha:]]/ =~ letter)
    
    letter = letter.downcase # Do all work in lowercase so we don't have to check later
    
    if @guesses.include?(letter) || @wrong_guesses.include?(letter) # Test for a letter already used
      return false
    end
    
    # The letter hasn't been used before, so it is either right or wrong.
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    
    if word_with_guesses == word
      return :win
    end
    
    return :play
  end
  
  def word_with_guesses
    # Make a string with dashes for unguessed letters, whille showing correct guesses in place.
    # e.g. '-ookk-----' for word 'bookkeeper' and guesses 'o' and 'k'
    wwg = ''
    @word.chars {|x| wwg += @guesses.include?(x) ? x : '-'}
    return wwg
  end
end
