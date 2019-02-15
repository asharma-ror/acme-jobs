# frozen_string_literal: true

class AddJobToTrelloJob < ApplicationJob
  queue_as :default

  def perform(job_id)
    begin
      job = Job.find(job_id)
    rescue StandardError => _error
      return
    end
    trello_list = TrelloFetchListInteraction.run(list_id: job.trello_list_id)

    return if trello_list.valid?

    trello_list = TrelloCreateListInteraction.run(title: job.title).result

    job.update(trello_list_id: trello_list.id) if trello_list.present?
  end
end
