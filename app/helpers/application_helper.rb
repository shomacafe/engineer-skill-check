module ApplicationHelper
  BASE_TITLE = "お知らせ&社員紹介サイト".freeze

  def full_title(page_title)
    page_title.blank? ? BASE_TITLE : "#{page_title} - #{BASE_TITLE}"
  end
end
