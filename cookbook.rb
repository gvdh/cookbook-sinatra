require 'csv'
require_relative 'recipe'
require_relative 'view'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(csv_file_path) do |row|
      @recipes << Recipe.new(name: row[0].to_s, description: row[1].to_s, difficulty: row[2].to_s, ingredients: row[3].to_s, preparation: row[4].to_s, cooking_time: row[5].to_s, done: "[ ]")
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def update_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.difficulty, recipe.ingredients, recipe.preparation, recipe.cooking_time] }
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index - 1)
    update_csv
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index - 1].done = "[ X ]"
    update_csv
  end
end

