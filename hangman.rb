# Read the dictionary file
dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)

class Hangman
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = ""
    @correct_length_words = []
    select_desired_words
    generate_secret_word # Call this method to generate the secret word on initialization
  end

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

  def display_correct_length_words
    puts @correct_length_words
  end
end

# Create a new instance of Hangman with the dictionary
game = Hangman.new(dictionary)
