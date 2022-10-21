class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      flash[:notice] = "Profile '#{@profile.username}' was created successfully."
      render :new, status: :created
    else
      flash[:notice] = "Unable to create profile."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.permit(:username)
  end
end
