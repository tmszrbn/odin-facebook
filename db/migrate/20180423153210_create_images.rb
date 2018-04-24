class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :imageable, polymorphi: true, index: true
      t.timestamps
    end
  end
end
