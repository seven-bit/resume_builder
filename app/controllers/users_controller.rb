class UsersController < ApplicationController

    def new
        @user = User.new
    end
      
    def create
        @user = User.new(user_params)
        @user.profile = Profile.new
        if @user.save
          flash[:notice] = "User created."
          @user.profile.educations.create
          redirect_to(root_path)
        else
          render('new')
        end
      end
      
     private
      
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
end
