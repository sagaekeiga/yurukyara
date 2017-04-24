class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :region
      t.text :profile
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :image4
      t.string :image5
      t.string :evolution1
      t.string :image6
      t.string :image7
      t.string :image8
      t.string :image9
      t.string :image10

      t.timestamps
    end
  end
end
