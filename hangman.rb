class Hangman

  attr_reader :wrong_guesses

  def initialize(phrase)
    @solution = phrase.upcase
    @current_state = @solution.gsub(/[A-Z]/, '_')
    @wrong_guesses = ''
  end

  def wrong_guess_count
    @wrong_guesses.length
  end

  def solved?
    @solution == @current_state
  end

  def lost?
    wrong_guess_count >= 7
  end

  def over?
    solved? or lost?
  end

  def guess_letter(letter)
    return nil if over?
    return nil unless letter.instance_of?(String) and letter[0]
    guess = letter[0].upcase
    return nil unless guess.match(/[A-Z]/)

    if @solution.include?(guess)
      fill_in_letter(guess)
    else
      @wrong_guesses += guess unless @wrong_guesses.include?(guess)
    end
  end

  def printable_state
    if over?
      @solution.gsub(/./, '\0 ').rstrip
    else
      @current_state.gsub(/./, '\0 ').rstrip
    end
  end


  private 

  def fill_in_letter(letter)
    @solution.length.times do |i|
      @current_state[i] = @solution[i] if @solution[i] == letter
    end
  end

end
