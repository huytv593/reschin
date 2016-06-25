# == Schema Information
#
# Table name: checkins
#
#  id            :integer          not null, primary key
#  comment       :string
#  image         :string
#  restaurant_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_checkins_on_restaurant_id  (restaurant_id)
#  index_checkins_on_user_id        (user_id)
#

class Checkin < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
end