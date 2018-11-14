class CreatePolicyManagerPortabilityRequests < ActiveRecord::Migration
  def change
    create_table :policy_manager_portability_requests do |t|
      t.string :state, index: true
      t.integer :user_id
      t.string :attachment
      t.string :attachment_file_name
      t.string :attachment_file_size
      t.datetime :attachment_content_type
      t.string :attachment_file_content_type

      t.timestamps
    end
  end
end
