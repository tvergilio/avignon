class CreateDirectors < ActiveRecord::Migration
  def self.up
    create_table :directors do |t|
	  t.belongs_to :company
      t.integer :company_id
      t.string :forename
      t.string :surname
      t.timestamps
    end
  end

  def self.down
    drop_table :directors
  end
end
