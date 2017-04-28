class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :region
      t.text :profile
      t.binary :image1
      t.binary :image2
      t.binary :image3
      t.binary :image4
      t.binary :image5
      t.binary :evolution

      t.timestamps
    end
  end
end
