class Recipe
  attr_reader :name, :description, :ingredients, :preparation, :difficulty, :cooking_time
  attr_accessor :done
  def initialize(infos = {})
    infos[:name] ? @name = infos[:name] : @name = "N/A"
    infos[:description] ? @description = infos[:description] : @description = "N/A"
    infos[:difficulty] ? @difficulty = infos[:difficulty] : @difficulty = "N/A"
    infos[:ingredients] ? @ingredients = infos[:ingredients] : @ingredients = "N/A"
    infos[:preparation] ? @preparation = infos[:preparation] : @preparation = "N/A"
    infos[:cooking_time] ? @cooking_time = infos[:cooking_time] : @cooking_time = "N/A"
    @done = "[ ]"
  end
end
