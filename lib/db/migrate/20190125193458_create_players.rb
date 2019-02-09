class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
		t.string :name, null: false
		t.integer :number, null: false
		t.string :picked_game, null: true
		t.boolean :winner
    end
  end
end
