# frozen_string_literal: true

class AddApplicantToTrelloJob < ApplicationJob
  def perform(job_applicant_id)
    begin
      job_applicant = JobApplicant.find(job_applicant_id)
    rescue StandardError => _error
      return
    end

    job = job_applicant.job
    candidate = job_applicant.candidate
    return unless job.trello_list_id.present?

    TrelloCreateCardInteraction.run(job: job, candidate: candidate)
  end
end
