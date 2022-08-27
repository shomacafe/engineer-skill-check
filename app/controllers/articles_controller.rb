class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @articles = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.employee = current_user
    if @article.save
      redirect_to articles_url, notice: "お知らせ「#{@article.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :employee_id)
  end
end
