class TranslatePolicies < ActiveRecord::Migration
  def self.up
    PolicyManager::Policy.create_translation_table!({
                                       name: :string,
                                       content: :text
                                   }, {
                                       migrate_data: true,
                                       remove_source_columns: true
                                   })
  end

  def self.down
    PolicyManager::Policy.drop_translation_table! migrate_data: true
  end
end
