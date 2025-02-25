class LabReport < ApplicationRecord
  belongs_to :user

  GRADES = %w[A B C D E FX F].freeze

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :grade, inclusion: { in: GRADES }, allow_blank: true
end
