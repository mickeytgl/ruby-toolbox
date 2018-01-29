class CreateToolCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :tool_categories do |t|
      t.string :name
      t.string :slug
      t.string :description

      t.timestamps
    end
  end
end
