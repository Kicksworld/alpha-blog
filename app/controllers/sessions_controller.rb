class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            flash[:notice] = "You have successfully logged in"
            session[:user_id] = user.id
            redirect_to user
        else
            flash.now[:alert] = "Invalid email or password"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Successfully logged out"
        redirect_to root_path
    end


end
