class UsersController < ApplicationController

    def new
        @user = User.new()
    end

    def create
        @user = User.new(user_params)
        if @user.save
        flash[:notice] = "User is successfully created"
        redirect_to @user
        else
            render 'new'
        end
    end

    def update
    end
end