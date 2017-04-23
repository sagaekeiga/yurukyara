class CreateDictionaries < ActiveRecord::Migration[5.0]
  def change
    create_table :dictionaries do |t|
      t.text :word
      t.text :res

      t.timestamps
    end
  end
end
