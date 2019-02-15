class AddTrelloListIdToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :trello_list_id, :string
  end
end
