require "json"
require "sinatra/base"
require_relative "check_params"
require_relative "deployment"

class Api < Sinatra::Base
  get '/' do
    'Hello World'
  end

  get '/doing' do
    'test'
  end

  get '/api/deploy/:title/:key' do
    blog_title = params["title"]
    hash_key = params["key"]
    check = CheckParams.new(blog_title, hash_key, pages)
    return blog_not_present! unless check.blog_available?
    return wrong_key! unless check.key_correct?
    deploy_blog
  end

  not_found do
    status 404
    "page not found"
  end

  def pages
    path = File.expand_path('../../config/pages.json', __FILE__)
    JSON.parse(File.read(path))
  end

  def blog_not_present!
    "blog not present"
  end

  def wrong_key!
    status 403
    "Key not allowed"
  end

  def deploy_blog
    deployment = Deployment.new(@blog_title,@hash_key,pages)
    deployment.deploy!
  end

  run!
end

