require "json"

class CheckParams
  def initialize(blog_title, hash_key, pages)
    @pages = pages
    @blog_title = blog_title
    @hash_key = hash_key
  end

  def blog_available?
    pages.keys.include? @blog_title
  end

  def key_correct?
    pages[@blog_title]["key"].equal? @hash_key
  end
end
