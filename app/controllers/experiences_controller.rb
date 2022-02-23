class ExperiencesController < ApplicationController
    # before_action :logged_in_user, only: [:new]

    include HomeHelper
  

    before_action :logged_in_user, only: [:update]
    before_action :correct_user,   only: [:update]

    def new
        current_user.profile.experiences.create
        flash[:success] = "Experience added."
        redirect_to edit_url 
        
    end 

    def update
        # updated_experience_params = update_array_attributes_in_params(experience_params)
        @experience = Experience.find(params[:id])
        if @experience.update(experience_params)
            flash[:success] = "Experience updated successfully."
            redirect_to edit_url
        else
            flash[:danger] = "Experience update failed."
            redirect_to root_url
        end
    end

    def correct_user
        @experience = Experience.find(params[:id])
        @profile = Profile.find(@experience.profile_id)
        @user = User.find(@profile.user_id)
        redirect_to(root_url) unless @user == current_user
    end 

    private
        def experience_params
            params.require(:experience).permit(:company, :position,:description, :start, :end, 
                :projects_attributes => [ :id, :title, :url, :description, :stack, :_destroy]
            )
        end




end
 