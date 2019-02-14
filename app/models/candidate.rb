class Candidate < ApplicationRecord
  has_many :job_applicants
  has_many :jobs, through: :job_applicants
end
