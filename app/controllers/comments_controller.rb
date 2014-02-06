class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post

    authorize! :create, @comment, message: "You need be signed in to do that."
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'posts/show'
  end
end
