class LabReport < ApplicationRecord
  belongs_to :user

  GRADES = %w[A B C D E FX F].freeze

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :grade, inclusion: { in: GRADES }, allow_blank: true
end

# == Schema Information
#
# Table name: lab_reports
#
#  id          :bigint           not null, primary key
#  description :text
#  grade       :string(2)
#  title       :string(250)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_lab_reports_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
