class CreateSpells < ActiveRecord::Migration
  def self.up
    create_table :spells do |t|
      t.string :name
      t.integer :school

      t.timestamps
    end
  end

  def self.down
    drop_table :spells
  end
end
