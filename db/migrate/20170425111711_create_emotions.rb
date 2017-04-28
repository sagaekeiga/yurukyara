class CreateEmotions < ActiveRecord::Migration[5.0]
  def change
    create_table :emotions do |t|
      t.text :word
      t.text :reading
      t.text :pos
      t.text :semantic_orientations
      

      t.timestamps
    end
    add_index :emotions, :word
  end
end
