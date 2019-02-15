# frozen_string_literal: true

class TrelloFetchListInteraction < ActiveInteraction::Base
  string :list_id
  validates :list_id, presence: true

  def execute
    Trello::List.find(list_id)
  rescue StandardError => _error
    nil
  end
end
