class CreatePolicyManagerPortabilityRequests < ActiveRecord::Migration
  def change
    create_table :policy_manager_portability_requests do |t|
      t.integer :user_id, index: true
      t.string :attachment
      t.string :attachment_file_name
      t.string :attachment_file_size
      t.string :attachment_content_type
      t.string :attachment_file_content_type
      t.datetime :job_completed_at
      t.datetime :job_failed_at

      t.timestamps
    end
  end
end
