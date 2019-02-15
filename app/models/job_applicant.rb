# frozen_string_literal: true

class JobApplicant < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
end
