class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @articles = Article.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
