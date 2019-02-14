class CreateJobApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :job_applicants do |t|
      t.integer :job_id
      t.integer :candidate_id
      t.text :cover_letter

      t.timestamps
    end
  end
end
