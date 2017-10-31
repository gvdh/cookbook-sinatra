require_relative 'view'
require_relative 'scrape_marmiton'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.list_all(@cookbook.all)
  end

  def create
    array = @view.ask_for_name_desc
    new_recipe = Recipe.new(name: array[0], description: array[1], difficulty: array[2], cooking_time: array[3])
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    list
    index = @view.delete
    @cookbook.remove_recipe(index) if index != 0
  end

  def import
    keyword = @view.importing
    @scrape_marmiton = ScrapeMarmiton.new(keyword)
    @results = @scrape_marmiton.call
    @selection = @view.importing_results(@results)
    @results_of_selection = @scrape_marmiton.import_selection(@selection)
    @view.selection_results(@results_of_selection)
    new_recipe = Recipe.new(@results_of_selection)
    @cookbook.add_recipe(new_recipe)
  end

  def done?
    list
    @check = @view.mark_as_done
    @cookbook.mark_as_done(@check)
  end
end
