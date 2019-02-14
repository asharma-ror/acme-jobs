class Job < ApplicationRecord
  has_many :job_applicants
  has_many :candidates, through: :job_applicants

  default_scope { where('closing_date > ? ',  Time.now) }
end
