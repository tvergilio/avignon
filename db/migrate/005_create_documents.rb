class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.belongs_to :director
      t.string :name
      t.integer :director_id
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
