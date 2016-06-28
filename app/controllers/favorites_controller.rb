class FavoritesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    if favorite.save
      flash[:notice] = "This post added to your favorites!"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Error! try to favorite the post again"
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user = current_user
    favorite = @user.favorited(@post)
    authorize favorite
    if favorite.destroy
      flash[:notice] = "This post has removed from your favorites!"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Error! try to removed the post from favorites again"
      redirect_to [@post.topic, @post]
    end
  end
end
