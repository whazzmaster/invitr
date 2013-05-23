class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name
      t.integer :attending
      t.text :message

      t.timestamps
    end
  end
end
