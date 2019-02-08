class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
    	t.string :name, null: false
    	t.datetime :last_played
    end
  end
end
