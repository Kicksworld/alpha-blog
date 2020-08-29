class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def show
        @pagy, @articles = pagy(@user.articles, items: 5)
    end

    def index
        @pagy, @user = pagy(User.all, items: 5)
    end

    def edit   
       
    end

    def create
        @user = User.new(user_params)
        if @user.save
        session[:user_id] =@user.id
        flash[:notice] = "Welcome #{@user.username}, you have successfully signed up"
        redirect_to @user
        else
            render 'new'
        end
    end

    def update
        if @user = User.update(user_params)
            flash[:notice] = "User details has been successfully updated"
             redirect_to user_path
             else
                render 'edit'
             end    
    end 

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:alert] = "User has been deleted successfully"
        redirect_to articles_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
    
    def user_params
    params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You don't have permission to perform this action"
            redirect_to @user
        end
            
    end

end