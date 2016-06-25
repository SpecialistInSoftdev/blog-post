class ArticlesController < ApplicationController
  
  before_action :authenticate_user!

  def index
    params[:sort] ||= "title"
    params[:direction] ||= "asc"
    
    if params[:sort] != "title" && params[:sort] != "text" && params[:sort] != "created_at"
      params[:sort] = "title"
    end
    #handle boundary cases : if user enter an messy url for sort which doesn't exist : then set to default sort by name
    if params[:direction] != "asc" && params[:direction] != "desc"
      params[:direction] = "asc"
    end
    
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 4).order(params[:sort] + " " + params[:direction])
    else
      @articles = Article.paginate(:page => params[:page], :per_page => 4).order(params[:sort] + " " + params[:direction])
    end

  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Artical successfully created"
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
    params.require(:article).permit(:title, :text, :image, :tag_list)
  end
end
