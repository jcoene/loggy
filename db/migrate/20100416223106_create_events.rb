class CreateEvents < ActiveRecord::Migration
	def self.up
		create_table :events do |t|
			t.datetime :ts
			t.string :event
			t.integer :log_id
			t.integer :segment_id
			t.integer :source_id
			t.integer :dest_id
			t.integer :spell_id
			t.integer :extra_spell_id
			t.integer :amount
			t.integer :overkill
			t.integer :resisted
			t.integer :blocked
			t.integer :absorbed
			t.boolean :critical
			t.boolean :glancing
			t.boolean :crushing
			t.string :type
			t.timestamps
		end
	end

	def self.down
		drop_table :events
	end
end
