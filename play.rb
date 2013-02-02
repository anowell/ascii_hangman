require_relative 'hangman_ascii'

def run

  puts 'Enter a phrase to guess:'
  game = AsciiHangman.new gets.strip

  until game.over?
    system 'clear'
    puts game.printable_state
    puts 'Enter a guess:'
    letter = gets.strip
    game.guess_letter letter
  end

  system 'clear'
  puts game.printable_state
end

run