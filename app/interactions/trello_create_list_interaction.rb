# frozen_string_literal: true

class TrelloCreateListInteraction < ActiveInteraction::Base
  string :title
  validates :title, presence: true

  def execute
    set_job_board
    return unless @job_board.present?

    Trello::List.create(name: title, board_id: @job_board.id, pos: 0)
  end

  private

  def set_job_board
    @job_board = Trello::Board.all.detect { |b| b.name.casecmp('jobs').zero? }

    return unless @job_board.blank?

    @job_board = Trello::Board.create(
      name: 'Jobs',
      description: 'This board is for testing'
    )
  end
end
