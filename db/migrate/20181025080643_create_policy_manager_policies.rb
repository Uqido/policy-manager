class CreatePolicyManagerPolicies < ActiveRecord::Migration
  def change
    create_table :policy_manager_policies do |t|
      t.string :policy_type
      t.text :content
      t.integer :version
      t.boolean :blocking

      t.timestamps null: false
    end
  end
end
