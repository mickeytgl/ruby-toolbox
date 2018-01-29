class CreateTools < ActiveRecord::Migration[5.1]
  def change
    create_table :tools do |t|
      t.references :tool_category, foreign_key: true
      t.string :name
      t.string :slug
      t.string :description
      t.string :git_host
      t.string :repo
      t.string :gem_name
      t.datetime :last_commit_at
      t.datetime :last_release_at
      t.float :score

      t.timestamps
    end
  end
end
