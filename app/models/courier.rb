class Courier < ApplicationRecord
  validates :code, :name, presence: true
end