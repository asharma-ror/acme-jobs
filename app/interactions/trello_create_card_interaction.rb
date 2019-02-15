# frozen_string_literal: true

class TrelloCreateCardInteraction < ActiveInteraction::Base
  object :candidate, :job
  validates :job, :candidate, presence: true

  def execute
    Trello::Card.create(
      name: candidate.name,
      list_id: job.trello_list_id,
      pos: 'top'
    )
  end
end
