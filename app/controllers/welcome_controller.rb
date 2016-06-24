class WelcomeController < ApplicationController
  def index
    @articles = Article.paginate(:page => params[:page], per_page: 4)
  end
end
