class Tool < ApplicationRecord
  belongs_to :tool_category

  extend FriendlyId
  friendly_id :name, use: :slugged
end
