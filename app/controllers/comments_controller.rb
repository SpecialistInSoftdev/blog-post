class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    params = comment_params
    params[:commenter] = current_user.email.split('@')[0]
    params[:user_id] = current_user.id
    @comment = @article.comments.create(params)
    redirect_to article_path(@article)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@comment.article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
