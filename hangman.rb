# Read the dictionary file
dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)

class Hangman
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = ""
    @correct_length_words = []
    $word_place_holder = [] # may end up as a string
    $incorrect_guesses_array = [] 
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
    $secret_word_array_version = @secret_word.chars # Assign here after @secret_word is set
    puts @secret_word
  end

  def generate_placeholder
    letter_number = @secret_word.length
    $word_place_holder = Array.new(letter_number, "_")
    puts $word_place_holder.join(" ")
  end

  def guess_a_letter
    letter_index = 0
    puts "guess a letter"
    $letter_guess = gets.chomp
    if @secret_word.include?($letter_guess)
      $secret_word_array_version.each_with_index do |letter, index|
        if letter == $letter_guess
          letter_index = index
          $word_place_holder[letter_index] = letter
        end
      end
    else 
      route_incorrect_guess 
    end 
    puts $word_place_holder.join(" ") 
  end

  def route_incorrect_guess
    $incorrect_guesses_array << $letter_guess 
    puts "#{$letter_guess} is an incorrect guess"
    puts "The list of incorrect letters so far is: #{$incorrect_guesses_array}" 
  end 

  def begin_game
    select_desired_words
    generate_secret_word
    generate_placeholder
    guess_a_letter
  end
end

# Create a new instance of Hangman with the dictionary
game = Hangman.new(dictionary)
game.begin_game