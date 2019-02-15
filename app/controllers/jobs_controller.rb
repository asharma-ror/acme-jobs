class JobsController < ApplicationController
  before_action :find_candidate, only: :save_candidate

  def index
    @jobs = Job.paginate(page: params[:page], per_page: 10)
  end

  def show
    @job = Job.find(params[:id])
  rescue StandardError
    redirect_to jobs_path,
     flash: { error: "You don't have an access to the requested resource." }
  end

  def apply
    @candidate = Candidate.new
    @job_applicant = @candidate.job_applicants.build
  end

  def save_candidate
    job_applicant_service = JobApplicantService.new(candidate_params, job_applicant_params)
    @candidate = job_applicant_service.save_candidate(@candidate)

    if @candidate.valid?
      find_candidate_job
      @job_applicant = job_applicant_service.save_job(@job_applicant)
      redirect_to jobs_path and return if @job_applicant.valid?
    end

    render 'apply'
  end

  def candidates
    begin
      @job = Job.find(params[:id])
    rescue StandardError
      redirect_to jobs_path,
       flash: { error: "You don't have an access to the requested resource." }
    end
    @candidates = @job.candidates.paginate(page: params[:page], per_page: 10)
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :email)
  end

  def job_applicant_params
    params.require(:candidate).require(:job_applicant).permit(:cover_letter, :job_id)
  end

  def find_candidate
    @candidate = Candidate.find_by(email: candidate_params[:email])
  end

  def find_candidate_job
    @job_applicant = JobApplicant.find_by(job_id: params[:id], candidate_id: @candidate.id)
  end
end
