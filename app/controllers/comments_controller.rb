class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(topic_params)
    
    @comment.post = Post.find(params[:post_id])
    @comment.user = current_user
    topic = @comment.post.topic
    if @comment.save
      redirect_to [topic, @comment.post], notice: "Comment was saved successfully."
    else
      flash[:error] = "Error creating comment. Please try again"
      redirect_to [topic, @comment.post]
    end
  end

  def topic_params
    params.require(:comment).permit(:body)
  end
end
