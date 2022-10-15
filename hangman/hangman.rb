require 'colorize'
require 'json'
require 'pry-byebug'
require 'time'
puts "\e[H\e[2J"


class Hangman
  @option = ''
  @user_letter = ''
  @@used_letters = Array.new(0)
  @random_word = []
  @hang = []
  @guesses_left = 0
  
  def initialize
    puts "\e[H\e[2J"
    wordfile = File.open('words.txt', 'r')
    lines = wordfile.readlines
    wordfile.close
    words = lines.map(&:strip)
    words.delete_if { |word| !word.length.between?(5, 12) }

    @random_word = words.sample.split('')
    @hang = []

    @random_word.length.times do
      @hang.push('_')
    end

    @guesses_left = (0.85 * @random_word.length).to_i
    puts 'Do you want to start a (n)ew game or to (l)oad a save?'
    @option = gets.chomp
    until @option == 'n' || @option == 'l'
      @option = gets.chomp
    end


    if @option == 'l'
      load 
    end

    until ended? != false
      display
      play
    end
      
    puts ended?
  end

  def play
    alphabet = ('a'..'z').to_a
    
    puts "Enter a valid letter (or save by typing 1):"
    @user_letter = gets.chomp.downcase
    
    until alphabet.include?(@user_letter) && !@@used_letters.include?(@user_letter)
      if @user_letter == '1'
        save
      else
        @user_letter = gets.chomp.downcase
      end
    end

    @random_word.each_with_index do |letter, index|
      if @user_letter == letter
        @hang[index] = @user_letter
        @@used_letters.push(letter)
      end
    end

    unless @random_word.include? @user_letter
      @@used_letters.push(@user_letter)
      @guesses_left -= 1
    end
  end

  def display
    puts "\e[H\e[2J"
    puts "Hangman".yellow
    puts "\n"
    puts 'Word: ' + @hang.join(' ') + "\n"
    puts 'Guesses Left: ' + @guesses_left.to_s.green
    puts 'Used letters: ' + @@used_letters.join(' ').red + "\n\n"
  end

  private
  def ended?
    if @guesses_left.zero?
      return "\nYou lost by running out of guesses! Bad luck!\nThe word was #{@random_word.join('')}"
    elsif !@hang.include? '_'
      return "\nYou won! The word was #{@hang.join('')}".green
    else
      return false
    end
  end

  def save
    puts "\e[H\e[2J"
    json = {
      "option" => @option,
      "user_letter" => @user_letter,
      "used_letters" => @@used_letters,
      "random_word" => @random_word,
      "hang"=> @hang,
      "guesses_left" => @guesses_left
    }
    time = Time.now
    filename = "hangman-#{time.day}#{time.month}#{time.year}-#{time.hour}#{time.min}.json" 
    File.open(filename, 'w') { |file| file.puts JSON.pretty_generate(json) }
    abort("Game was saved as #{filename}!")
  end

  def load
    puts "\e[H\e[2J"
    save_hash = {}
    saves = Dir.glob('*.json')
    saves.each_with_index { |save, index| save_hash[index] = save}
    puts save_hash
    puts "\nEnter the number corresponding to the save you wish to load!"
    save_index = gets.chomp
    
    until save_hash.keys.include?(save_index.to_i)
      save_index = gets.chomp
    end

    save = File.read(saves[save_index.to_i])
    data_hash = JSON.parse(save)
    @option = data_hash["option"]
    @user_letter = data_hash["user_letter"]
    @@used_letters = data_hash["used_letters"]
    @random_word = data_hash["random_word"]
    @hang = data_hash["hang"]
    @guesses_left = data_hash["guesses_left"]
    puts "\e[H\e[2J"
    puts "Save Loaded!\n"
  end
end

Hangman.new