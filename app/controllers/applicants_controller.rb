# frozen_string_literal: true

class ApplicantsController < ApplicationController
  def index
    begin
      @job = Job.find(params[:job_id])
    rescue StandardError
      redirect_to jobs_path,
                  flash: {
                    error: "You don't have an access to the requested resource."
                  }
    end
    @candidates = @job.candidates.paginate(page: params[:page], per_page: 10)
  end

  def new
    @candidate = Candidate.new
    @job_applicant = @candidate.job_applicants.build
  end

  def create
    @job = Job.find_by_id(params[:job_id])
    if @job.closed?
      flash[:error] = 'Job Post is already closed'
    else
      @candidate = Candidate.find_or_create_by(email: candidate_params[:email])
      @candidate.update_attribute(:name, candidate_params[:name])

      @job_applicant = JobApplicantInteraction.run(
        job: @job,
        candidate: @candidate,
        cover_letter: job_applicant_params[:cover_letter]
      )
      redirect_to(jobs_path) && return if @job_applicant.valid?
    end
    render 'new'
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :email)
  end

  def job_applicant_params
    params.require(:candidate).require(:job_applicant).permit(:cover_letter)
  end
end
