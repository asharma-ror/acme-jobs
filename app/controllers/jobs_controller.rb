class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :email)
  end

  def job_applicant_params
    params.require(:candidate).require(:job_applicant).permit(:cover_letter, :job_id)
  end
end
