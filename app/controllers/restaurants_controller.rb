# == Schema Information
#
# Table name: restaurants
#
#  id          :integer          not null, primary key
#  name        :string
#  about       :text
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#
# Indexes
#
#  index_restaurants_on_location_id  (location_id)
#

class RestaurantsController < ApplicationController
  def index
    @banners = Banner.all.to_a.transform(3)
    @categories = Category.all
  end


  def show
    @restaurant = Restaurant.where(id: params[:id]).first

    @comments = @restaurant.comments
    @new_comment = Comment.new
    @favorites = Favorite.where(restaurant_id: @restaurant.id).count

    @checkin = Checkin.new

    if current_user
      @is_liked = Favorite.where(
          user_id: current_user.id, restaurant_id: @restaurant.id
      ).exists?
    end
  end

  def checkin
    @checkin = Checkin.new(checkin_params)
    @checkin.user = current_user
    @checkin.restaurant_id = params[:restaurant_id]
    if @checkin.save
      redirect_to restaurant_path(params[:restaurant_id])
    end
  end

  private
  def checkin_params
    params.required(:checkin).permit(:comment, :image, :restaurant_id)
  end
end
