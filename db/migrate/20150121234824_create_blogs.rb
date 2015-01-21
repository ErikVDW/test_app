class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :creator
      t.string :title
      t.text :body
      t.date :date

      t.timestamps
    end
  end
end
