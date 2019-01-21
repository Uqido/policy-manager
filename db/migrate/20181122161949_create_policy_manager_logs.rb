class CreatePolicyManagerLogs < ActiveRecord::Migration
  def change
    create_table :policy_manager_logs do |t|
      t.string :log_type
      t.string :description
      t.references :loggable, polymorphic: true, index: true
      t.integer :user_id, index: true
      t.timestamps
    end
  end
end