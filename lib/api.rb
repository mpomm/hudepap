require "json"
require "sinatra/base"
require_relative "check_params"
require_relative "deployment"

class Api < Sinatra::Base
  get "/" do
    "Hello World"
  end

  get '/api/deploy' do
    @blog_title = params["title"]
    @hash_key = params["key"]
    check = CheckParams.new(@blog_title, @hash_key, pages)
    blog_not_present! unless check.blog_available?
    wrong_key! unless check.key_correct?
    deploy_blog
  end

  not_found do
    status 404
    'page not found'
  end

  def pages
    file = File.read("../config/pages.json")
    JSON.parse(file)
  end

  def blog_not_present!
    status 404
    "blog not present"
    exit
  end

  def wrong_key!
    status 403
    "Key not allowed"
    exit
  end

  def deploy_blog
    deploy = Deployment.new
  end

  run!
end

