require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative "cookbook"
require_relative "recipe"
require_relative "service"


set :bind, '0.0.0.0'

csv_file = File.join(__dir__, 'recipes.csv')

cookbook = Cookbook.new(csv_file)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do # <- Router part
  @recipes = cookbook.all
  erb :index
end

get '/list' do
  @recipes = cookbook.all
  erb :list
end

get '/create' do
  erb :create
end

get '/create/post' do
  cookbook.add_recipe(Recipe.new(params["name"], params["description"], params["prep_time"], params["difficulty"]))
  @recipes = cookbook.all
  erb :index
end

get '/destroy' do
  @recipes = cookbook.all
  erb :destroy
end

get '/destroy/post' do
  cookbook.remove_recipe(params[:index].to_i - 1)
  @recipes = cookbook.all
  erb :index
end

get '/internet' do
  erb :internet
end

get '/internet/post' do
  @ingr = params['ingredient']
  @recip_net = ScrapeBbcGoodFoodService.new(@ingr).call
  erb :list_internet
end

get '/internet/post2' do
  index = params['choice'].to_i - 1
  @ingr = params['ingredient']
  @recip_net = ScrapeBbcGoodFoodService.new(@ingr).call
  cookbook.add_recipe(Recipe.new(@recip_net[0][index], @recip_net[1][index], @recip_net[2][index], @recip_net[3][index]))
  @recipes = cookbook.all
  erb :index
end

get '/mark_as_done' do
  @recipes = cookbook.all
  erb :mark_as_done
end

get '/mark_as_done/post' do
  cookbook.mark_done(params['index'].to_i - 1)
  @recipes = cookbook.all
  erb :index
end
