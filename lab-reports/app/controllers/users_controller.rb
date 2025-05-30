class UsersController < ApplicationController
  before_action :set_user, only: %w[show edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 9)
  end

  def show
    @lab_reports = @user.lab_reports.includes(:user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User was successfully deleted."
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
