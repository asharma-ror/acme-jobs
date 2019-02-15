# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :job_applicants
  has_many :candidates, through: :job_applicants
  before_save :set_closing_date
  before_save :titleize_job_title

  default_scope do
    where('closing_date > ? ', Time.now)
      .order('created_at DESC')
  end

  def closed?
    closing_date < Time.now
  end

  protected

  def set_closing_date
    self.closing_date = closing_date.end_of_day
  end

  def titleize_job_title
    self.title = title.titleize
  end
end
