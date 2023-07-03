# class RecipesController < ApplicationController
# before_action :authorize

# def index
    
#         recipes = Recipe.all

#     render json: recipes, include:[:user]

    
# end

# def create
#     recipe = Recipe.create(recipe_params)
    
#     if recipe.valid?
#         render json: recipe, include:[:user], status: :created
#     else
#         render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
#     end
# end


# private

# def recipe_params
#     params.permit(:title, :instructions, :minutes_to_complete)
# end
# def authorize
#     return render json:{error: 'Not authorized'}, status: :unauthorized unless session.include? :user_id
# end
# end
class RecipesController < ApplicationController
  before_action :authorize

  def index
    recipes = Recipe.all
    render json: recipes, include: [:user]
    # if recipes
    #     render json: recipes, include: [:user]
    # else
        
    # end
  end

#   def create
#     recipe = Recipe.create(recipe_params)
#    session[:user_id] 

#     if recipe.valid?

#       render json: recipe, include: [:user], status: :created
#     else
#       render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
#     end
#   end
def create
#   recipe = Recipe.create(recipe_params.merge(user_id:session[:user_id]))
  recipe = Recipe.create(recipe_params.merge(user_id: session[:user_id]))


  if recipe.valid?
    render json: recipe, include: [:user], status: :created
  else
    render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
  end
end

  private

  def recipe_params
    params.permit( :title, :instructions, :minutes_to_complete)
  end

  def authorize
    unless session.include?(:user_id)
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end
end