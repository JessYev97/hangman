# Read the dictionary file
dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)

class Hangman
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = ""
    @correct_length_words = []
  end
  $word_place_holder = [] # may end up as a string 

  def select_desired_words
    @dictionary.each do |word|
      if word.length > 4 && word.length < 13
        @correct_length_words << word
      end
    end
  end 

  def generate_secret_word
    $dictionary_length = @correct_length_words.length
    index_position = rand($dictionary_length)
    @secret_word = @correct_length_words[index_position]
    puts @secret_word
  end

  def generate_placeholder
    letter_number = @secret_word.length 
    $word_place_holder = Array.new(letter_number, "_") 
    puts $word_place_holder.join(" ")
  end 

  def begin_game
    select_desired_words
    generate_secret_word 
    generate_placeholder 
  end 

end

# Create a new instance of Hangman with the dictionary
game = Hangman.new(dictionary)
game.begin_game 
