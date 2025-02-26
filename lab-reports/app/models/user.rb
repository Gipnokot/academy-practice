class User < ApplicationRecord
  has_many :lab_reports, dependent: :destroy

    validates :first_name, presence: true, length: { maximum: 100 }
    validates :last_name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 150 },
                      format: { with: URI::MailTo::EMAIL_REGEXP }
end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string(150)      not null
#  first_name :string(100)      not null
#  last_name  :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
