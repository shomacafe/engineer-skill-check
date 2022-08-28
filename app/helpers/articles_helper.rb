module ArticlesHelper
  def sort_article(column)
    direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to column, { direction: direction }
  end
end
