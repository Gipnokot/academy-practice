class LabReportsController < ApplicationController
  before_action :set_lab_report, only: %w[show edit update destroy]
  before_action :load_users, only: %w[new create]

  def index
    @lab_reports = LabReport.includes(:user).paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @lab_report = LabReport.new
  end

  def create
    @lab_report = LabReport.new(lab_report_params)
    if @lab_report.save
      redirect_to @lab_report, notice: "Lab report successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @lab_report.update(lab_report_params)
      redirect_to @lab_report, notice: "Lab report successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lab_report.destroy
    redirect_to lab_reports_url, notice: "Lab report deleted"
  end

  private

  def set_lab_report
    @lab_report = LabReport.find(params[:id])
  end

  def load_users
    @users = User.select(:id, :first_name, :last_name).order(:first_name)
  end

  def lab_report_params
    params.require(:lab_report).permit(:title, :description, :grade, :user_id)
  end
end
