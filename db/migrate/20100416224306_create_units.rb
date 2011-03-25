class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.string :guid
      t.integer :flags
      t.integer :npc_id
      t.integer :log_id

      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
