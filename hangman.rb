# Read the dictionary file
dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)

class Hangman
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = ""
    @correct_length_words = []
    @head = ""
    $arms = "" 
    @right_arm = ""
    @left_arm = "" 
    @torso = "" 
    $legs = "" 
    @right_leg = ""
    @left_leg = ""
    
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
      puts $word_place_holder.join(" ")
    else
      route_incorrect_guess
    end

    check_game_status
  end

  def route_incorrect_guess
    $incorrect_guesses_array << $letter_guess
    puts "#{$letter_guess} is an incorrect guess"
    puts "The list of incorrect letters so far is: #{$incorrect_guesses_array.join(", ")}"
  end

  def check_game_status
    if $incorrect_guesses_array.length >= 6
      @head = " (x_x)"
      puts_body
      puts "The whole man is hung! You lost."
    elsif $word_place_holder.join("") == @secret_word
      puts "Well done! You won."
    else
      display_hanged_man
      puts_body
      guess_a_letter
    end
  end

  def display_hanged_man
    case $incorrect_guesses_array.length
    when 0
      puts "safe so far..."
    when 1
      @torso = "|"
    when 2
      @torso = "|"
      @left_leg = "/"
    when 3
      @torso = "|"
      @left_leg = "/" 
      @right_leg = "\\" 
    when 4
      @torso = "|"
      @left_leg = "/" 
      @right_leg = "\\" 
      @right_arm = "\\"
    when 5
      @torso = "|"
      @left_leg = "/" 
      @right_leg = "\\" 
      @right_arm = "\\" 
      @left_arm = "/" 
      puts "Watch out! He'll be hanged by his neck if you make another mistake!"
    when 6 
      @torso = "   |   "
      @left_leg = "      /" 
      @right_leg = "\\      " 
      @right_arm = "      /" 
      @left_arm = "      \\" 
      @head = " (x_x) "
    end
  end

  def puts_body
    puts @head 
    $arms = "#{@right_arm} #{@left_arm}"
    puts $arms 
    puts @torso
    $legs = "#{@right_leg} #{@left_leg}"
    puts $legs
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