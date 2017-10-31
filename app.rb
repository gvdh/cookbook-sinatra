require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'scrape_marmiton'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
scrape_marmiton = ScrapeMarmiton.new


get '/' do
  #@display = Router.run
  erb :index
end

get '/list' do
  @recipes = cookbook.all
  erb :list
end

get '/destroy' do
  @recipes = cookbook.all
  erb :destroy
end

post '/destroyed' do
  cookbook.remove_recipe(params[:number].to_i)
  @recipes = cookbook.all
  erb :destroyed
end

get '/add' do
  erb :create
end

get '/import' do
  erb :import
end

post '/create2' do
  recipe = Recipe.new(params)
  cookbook.add_recipe(recipe)
  redirect "/"
end

post '/importing' do
  @keyword = params[:text]
  @results = scrape_marmiton.call(@keyword)
  erb :importing
end

post '/importing2' do
  keyword2 = params[:number]
  results_of_selection = scrape_marmiton.import_selection(keyword2)
  new_recipe = Recipe.new(results_of_selection)
  cookbook.add_recipe(new_recipe)
  erb :importing2
end

get '/add' do
  erb :add
end
