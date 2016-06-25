# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  content       :text
#  restaurant_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_comments_on_restaurant_id  (restaurant_id)
#  index_comments_on_user_id        (user_id)
#

class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render partial: 'comments/comment',
        locals: {comment: @comment},
        status: :created
    end
    
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :restaurant_id)
  end
end
