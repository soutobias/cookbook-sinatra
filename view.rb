class View
  def all(cookbook)
    puts "-- Here are all your recipes --"
    puts ""
    cookbook.each_with_index do |recipe, index|
      recipe.done? ? x = "X" : x = " "
      puts "#{index + 1}. [#{x}] #{recipe.name} (#{recipe.prep_time} min)"
    end
  end

  def new_recipe
    puts "Insert a new name for a recipe"
    name = gets.chomp
    puts "Insert a description for the recipe"
    description = gets.chomp
    puts "Insert a prep time for the recipe"
    prep_time = gets.chomp
    puts "Insert a difficulty for the recipe"
    difficulty = gets.chomp
    return [name, description, prep_time, difficulty]
  end

  def select_recipe(action)
    puts "Whats is the number of the receipe you want to #{action}?"
    gets.chomp.to_i - 1
  end

  def ingredient
    puts "What ingredient would you like a recipe for?"
    gets.chomp
  end

  def list_internet(ingr, names)
    puts "Looking for '#{ingr}' recipes on the Internet..."
    puts ""
    names.each_with_index do |name, index|
      break if index >= 5

      puts "#{index + 1}. #{name}"
    end
    puts ""
    puts "Which recipe would you like to import? (enter index)"
    gets.chomp.to_i - 1
  end
end
