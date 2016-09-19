require 'json'

class CheckParams
  attr_reader :blog_title, :body, :pages

  def initialize(blog_title, body, pages)
    @pages = pages
    @blog_title = blog_title
    @body = body
  end

  def blog_available?
    pages.keys.include? blog_title
  end

  def verify_signature
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new('sha1'),
      pages[blog_title]['key'],
      body
    )
    unless Rack::Utils.secure_compare(
      signature,
      request.env['HTTP_X_HUB_SIGNATURE']
    )
      return halt 500, "Signatures didn't match!"
    end
  end
end
