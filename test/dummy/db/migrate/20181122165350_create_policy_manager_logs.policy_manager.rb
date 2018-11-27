# This migration comes from policy_manager (originally 20181122161949)
class CreatePolicyManagerLogs < ActiveRecord::Migration
  def change
    create_table :policy_manager_logs do |t|
      t.string :log_type
      t.string :description
      t.references :logable, polymorphic: true, index: true
      t.integer :user_id, index: true
      t.timestamps
    end
  end
end