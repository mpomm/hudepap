class Deployment
  def initialize(blog_title, hash_key, pages)
    @pages = pages
    @blog_title = blog_title
    @hash_key = hash_key
  end

  def deploy
    # get path systempath + path from config
    # cd into path
    # git pull
    # hugo to rebuild static html pages
    status 200
    "Deployment done"
  end
end
