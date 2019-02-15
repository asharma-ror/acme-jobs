# frozen_string_literal: true

class JobApplicantInteraction < ActiveInteraction::Base
  string :cover_letter
  object :job, :candidate
  validates :job, :candidate, presence: true

  def execute
    job_applicant = JobApplicant.find_or_initialize_by(
      job_id: job.id,
      candidate_id: candidate.id
    )
    job_applicant.cover_letter = cover_letter

    unless job_applicant.new_record?
      return (job_applicant.save && job_applicant)
    end

    if job_applicant.save
      AddApplicantToTrelloJob.perform_later job_applicant.id
      return job_applicant
    end

    false
  end
end
