class Tool < ApplicationRecord
  require 'csv'
  belongs_to :tool_category

  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Tool.create! row.to_hash
    end
  end


end
