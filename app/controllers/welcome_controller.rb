class WelcomeController < ApplicationController
  def index
    params[:sort] ||= "title"
    params[:direction] ||= "asc"
    @search = Article.search(params[:q])
    @articles = @search.result.paginate(:page => params[:page], per_page: 4).order(params[:sort] + " " + params[:direction])
  end
end
