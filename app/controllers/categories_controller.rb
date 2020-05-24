class CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def new
        @category = Category.new()
    end

    def create
        @category = Category.new(category_params)
    
        if @category.save
            flash[:notice] = "Game is successfully saved"
            redirect_to categories_path(@category)
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
            flash[:notice] = "Category is successfully updated"
            redirect_to categories_path(@category)
        else
            render 'edit'
        end
    end

    def destroy
        @category = Category.find(params[:id])
        
        @category.destroy
        flash[:notice] = "category was successfully deleted"
        redirect_to categories_path
      end

    def category_params
        params.require(:category).permit(:name)
    end
end
