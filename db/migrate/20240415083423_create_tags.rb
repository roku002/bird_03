class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tag_name

      t.timestamps

      t.index :tag_name, unique: true
    end
  end
end
