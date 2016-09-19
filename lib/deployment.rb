require "minigit"

class Deployment
  def initialize(blog_title, hash_key, pages)
    @pages = pages
    @blog_title = blog_title
    @hash_key = hash_key
  end

  def deploy!
    path = pages[@blog_title]["path"]
    git = MiniGit.new(path)
    git.capturing.pull :f
    # hugo to rebuild static html pages
    "Deployment done"
  end
end
