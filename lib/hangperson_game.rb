class HangpersonGame

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
  
  def dump
    ', guesses = ' + @guesses + ', wrong_guesses = ' + @wrong_guesses
  end
  
  def guess(letter)
    letter = letter.downcase
    puts 'letter = ' + letter
    if @word.include? letter
      if @guesses.include?(letter) || @wrong_guesses.include?(letter)
        puts 'that was a repeat'
        return false
      end
      @guesses += letter
      puts 'yes' + dump
      return true
    else
      @wrong_guesses += letter
      puts 'no' + dump
      return false
    end
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    
    if @guesses.length == @word.length
      return :win
    end
    
    return :play
  end
end
