class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.length
  end
 
  def guess(letter)
    if !letter or !letter.match?(/[A-Za-z]/)
      raise ArgumentError, "Must be a valid Letter!"
    end

    if @guesses.include? letter.downcase or @wrong_guesses.include? letter.downcase
      return false
    end
    if @word.include? letter.downcase
      @guesses << letter.downcase

      @word.chars.each_with_index do |ch , ind|
        if ch == letter.downcase
          @word_with_guesses[ind] = ch
        end
      end

      return true
    else
      @wrong_guesses << letter.downcase
      return true
    end
  end

  def check_win_or_lose
    if @word == @word_with_guesses
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end



  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
