require 'csv'
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(@csv_file_path, { col_sep: ',' }) do |row|
      row[4] == "true" ? done = true : done = false
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], done)
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_done(recipe_index)
    @recipes[recipe_index].already_done!
    save_csv
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb', { col_sep: ',' }) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done?]
      end
    end
  end
end
