require_relative "view"
require_relative "recipe"
require_relative "cookbook"
require_relative "service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.all(@cookbook.all)
    # list all receipes
  end

  def create
    recipe = @view.new_recipe
    @cookbook.add_recipe(Recipe.new(recipe[0], recipe[1], recipe[2], recipe[3]))
  end

  def destroy
    @view.all(@cookbook.all)
    @cookbook.remove_recipe(@view.select_recipe("delete"))
    # destroy an existing receipe
  end

  def mark_as_done
    @view.all(@cookbook.all)
    @cookbook.mark_done(@view.select_recipe("mark as done"))
  end

  def internet
    ingr = @view.ingredient
    recipes = ScrapeBbcGoodFoodService.new(ingr).call
    index = @view.list_internet(ingr, recipes[0])
    @cookbook.add_recipe(Recipe.new(recipes[0][index], recipes[1][index], recipes[2][index], recipes[3][index]))
  end
end
