class CreateTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :teams do |t|
      t.references :game, null: false, foreign_key: true
      t.string :name
      t.string :color
      t.integer :position
      t.boolean :on_board
      t.integer :turns_count
      t.text :last_instruction

      t.timestamps
    end
  end
end
