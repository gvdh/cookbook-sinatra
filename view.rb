require 'colorize'
require 'io/console'

class View
  # attr_reader :height, :width
  def list_all(array)
    array.each_with_index { |i, index| puts "#{index + 1}. - #{i.done} #{i.name} (#{i.cooking_time}) - Difficulty : #{i.difficulty}" }
  end

  def prompt
    @width = IO.console.winsize[1]
    (@width / 4).times { print " " }
    print ">>".green
  end

  def height
    @height = IO.console.winsize[0]
  end

  def width
    @width = IO.console.winsize[1]
  end

  def middle_centered
    @width = IO.console.winsize[1]
    @height = IO.console.winsize[0]
    (@height / 2).times { puts " " }
    (@width / 4).times { print " " }
  end

  def ask_for_name_desc
    puts "What's the name of your recipe ?".red
    name = gets.chomp
    puts "What's the description of your recipe ?".red
    description = gets.chomp
    puts "What's the level of difficulty of your recipe ?".red
    difficulty = gets.chomp
    puts "What's the time of cooking of your recipe ?".red
    cooking_time = gets.chomp
    [name, description, difficulty, cooking_time]
  end

  def delete
    puts "What recipe do you want to destroy ?"
    index = gets.chomp.to_i
    index
  end

  def importing
    middle_centered
    puts "What ingredient would you like a recipe for?".red
    prompt
    @keyword = gets.chomp
  end

  def importing_results(my_array)
    puts "Looking for '#{@keyword}' on Marmiton... \n #{my_array.size} results found!"
    my_array.each_with_index { |element, index| puts "#{index + 1}. #{element}" }
    puts "Please type a number to choose which recipe to import"
    @selection = gets.chomp.to_i
    puts "Importing '#{my_array[@selection - 1]}'..."
    return @selection - 1
  end

  def selection_results(my_hash)
    puts "Your recipe - #{my_hash[:name]} - has been stored!"
  end

  def mark_as_done
    puts "Which recipe do you want to mark as done ?"
    gets.chomp.to_i
  end
end
