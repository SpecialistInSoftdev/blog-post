class WelcomeController < ApplicationController
  def index
    params[:sort] ||= "title"
    params[:direction] ||= "asc"
    @articles = Article.paginate(:page => params[:page], per_page: 4).order(params[:sort] + " " + params[:direction])
  end
end
