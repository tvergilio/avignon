class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :email
      t.string :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
