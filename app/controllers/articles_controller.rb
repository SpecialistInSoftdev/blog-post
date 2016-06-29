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
    @search = Article.search(params[:q])
    @tags = ActsAsTaggableOn::Tag.all
    
    if params[:tag]
      @articles = @search.result.includes(:tags).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 4).order(params[:sort] + " " + params[:direction])
    else
      @articles = @search.result.includes(:tags).paginate(:page => params[:page], :per_page => 4).order(params[:sort] + " " + params[:direction])
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
    authorize! :create, @article
    if @article.save
      flash[:notice] = "Artical successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    authorize! :update, @article
    #authorized! if can? :update, @article or current_user.id == @article.user_id
  end
  
  def update
    @article = Article.find(params[:id])
    authorize! :update, @article
    if @article.update(article_params)
      flash[:notice] = "Artical successfully updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize! :destroy, @article
    @article.destroy
    flash[:notice] = "Artical successfully Deleted"
    redirect_to articles_path
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text, :image, :tag_list)
  end
end
