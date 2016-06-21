class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    flash[:notice] = "Artical successfully created"
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def update
      @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Artical successfully updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Artical successfully Deleted"
    redirect_to articles_path
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end