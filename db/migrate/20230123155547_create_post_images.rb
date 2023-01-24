class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.references :post, null: false, foreign_key: { to_table: :posts }
      t.string :image_id, null: false

      t.timestamps
    end
  end
end
