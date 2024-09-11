class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :board_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
