class JobApplicantService
	attr_reader :candidate_params, :job_applicant_params

	def initialize(candidate_params, job_applicant_params)
		@candidate_params = candidate_params
		@job_applicant_params = job_applicant_params
	end

  def save_candidate(candidate = nil)
	  @candidate = candidate
	  @candidate.present? ? update_candidate : create_candidate
	end

	def save_job(job_applicant = nil)

		@job_applicant = job_applicant
		@job_applicant.present? ? update_job : create_job
  end

  private

	def update_candidate
		@candidate.update(candidate_params)
		@candidate
	end

	def update_job
		@job_applicant.update(job_applicant_params.merge(candidate_id: @candidate.id))
	  @job_applicant
	end

	def create_candidate
		Candidate.create(candidate_params)
	end

	def create_job
		JobApplicant.create(job_applicant_params.merge(candidate_id: @candidate.id))
	end
end
