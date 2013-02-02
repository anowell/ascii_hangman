require_relative 'hangman'

describe Hangman do

  it "empty string is solved" do
    game = Hangman.new ""
    game.solved?.should be_true
  end
  
  it "should be a valid puzzle for a simple word" do
    game = Hangman.new "TEST"
    game.solved?.should be_false
    game.printable_state.should == "_ _ _ _"
  end

  it "should fill in guessed letter" do
    game = Hangman.new "TEST"
    game.guess_letter "T"
    game.printable_state.should == "T _ _ T"
    game.solved?.should be_false    
  end

  it "should be solved when all letters are guessed" do
    game = Hangman.new "MOM"
    game.guess_letter "O"
    game.printable_state.should == "_ O _"
    game.guess_letter "M"
    game.printable_state.should == "M O M"
    game.solved?.should be_true    
  end

  it "should work for puzzles with spaces" do
    game = Hangman.new "yes sir"
    game.solved?.should be_false
    game.printable_state.should == "_ _ _   _ _ _"
  end

  it "should unmask any non-alphabet character" do
    game = Hangman.new '&@*$ that!'
    game.printable_state.should == '& @ * $   _ _ _ _ !'

    game = Hangman.new '"Why?" she asked.'
    game.printable_state.should == '" _ _ _ ? "   _ _ _   _ _ _ _ _ .'

    game = Hangman.new 'Call me @ 123-4567'
    game.printable_state.should == '_ _ _ _   _ _   @   1 2 3 - 4 5 6 7'
  end


  it "should ignore case" do
    game = Hangman.new "Car"
    game.guess_letter 'c'
    game.guess_letter 'R'
    game.printable_state.should == "C _ R"
  end

  context "Wrong guess_letter support" do
    before :each do
      @game = Hangman.new "Car"
    end

    it "should correctly count wrong guesses" do
      @game.wrong_guess_count.should == 0 
      @game.guess_letter 'o'
      @game.wrong_guess_count.should == 1 
      @game.guess_letter 'c'
      @game.wrong_guess_count.should == 1 
      @game.guess_letter 'd'
      @game.wrong_guess_count.should == 2 
    end

    it "should only count each wrong guess once" do
      @game.guess_letter 'o'
      @game.wrong_guess_count.should == 1 
      @game.guess_letter 'o'
      @game.wrong_guess_count.should == 1 
      @game.guess_letter 'O'
      @game.wrong_guess_count.should == 1 
    end

    it "should ignore non-alphabet guesses" do
      @game.guess_letter nil
      @game.wrong_guess_count.should == 0

      @game.guess_letter ''
      @game.wrong_guess_count.should == 0

      @game.guess_letter ' '
      @game.wrong_guess_count.should == 0

      @game.guess_letter '@'
      @game.wrong_guess_count.should == 0
    end

    it "should handle game over conditions" do
      @game.lost?.should be_false
      'zyxwvu'.each_char{|c| @game.guess_letter c }
      @game.lost?.should be_false

      @game.guess_letter 's'
      @game.lost?.should be_true
      @game.printable_state.should == "C A R"

      @game.guess_letter 'c'
      @game.lost?.should be_true
      @game.printable_state.should == "C A R"

      @game.guess_letter 'q'
      @game.lost?.should be_true
      @game.printable_state.should == "C A R"
    end
  end


end