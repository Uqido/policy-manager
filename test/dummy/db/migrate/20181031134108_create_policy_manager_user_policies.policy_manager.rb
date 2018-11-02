# This migration comes from policy_manager (originally 20181025105219)
 class CreatePolicyManagerUserPolicies < ActiveRecord::Migration
  def change
    create_table :policy_manager_user_policies do |t|
      t.integer :user_id
      t.integer :policy_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
