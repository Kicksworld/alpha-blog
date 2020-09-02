class CategoriesController < ApplicationController

    before_action :require_admin, except: [:index, :show]

    def show
        @category = Category.find(params[:id])
        @pagy, @articles = pagy(@category.articles, items: 5)
    end

    def new
        @category = Category.new()
    end

    def index
        @pagy, @categories = pagy(Category.all, items: 5)
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category is successfully created"
        redirect_to @category
        else
            render 'new'
        end

    end

    def edit
        @category = Category.find(params[:id])
      end
    
      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          flash[:notice] = "Category name updated successfully"
          redirect_to @category
        else
          render 'edit'
        end
      end

    private

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "You don't have permission to perform this action"
            redirect_to categories_path
        end    
    end
end
