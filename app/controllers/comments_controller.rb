class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(topic_params)
    
    @comment.post = Post.find(params[:post_id])
    @comment.user = current_user
    authorize @comment
    topic = @comment.post.topic
    if @comment.save
      redirect_to [topic, @comment.post], notice: "Comment was saved successfully."
    else
      flash[:error] = "Error creating comment. Please try again"
      redirect_to [topic, @comment.post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @topic = @post.topic
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end
  private

  def topic_params
    params.require(:comment).permit(:body)
  end
end
