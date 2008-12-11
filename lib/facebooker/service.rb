require 'curb'
require 'facebooker/parser'
module Facebooker
  class Service
    def initialize(api_base, api_path, api_key)
      @api_base = api_base
      @api_path = api_path
      @api_key = api_key
    end
    
    # TODO: support ssl 
    def post(params)
      attempt = 0
      Parser.parse(params[:method], Curl::Easy.http_post(url, to_curb_params(params)).body_str)
    rescue Errno::ECONNRESET, EOFError
      if attempt == 0
        attempt += 1
        retry
      end
    end
    
    def post_file(params)
      Parser.parse(params[:method], Curl::Easy.http_post(url, to_curb_params(params)) {|c| c.multipart_form_post? = true }.body_str)
    end
    
    private
    def url
      URI.parse('http://'+ @api_base + @api_path)
    end
    
    def multipart_post_file?(object)
      object.respond_to?(:content_type) &&
      object.respond_to?(:data) &&
      object.respond_to?(:filename)
    end
    
    def to_curb_params(params)
      params.collect do |k,v|
        multipart_post_file?(v) ? Curl::PostField.file(k, v.filename) : Curl::PostField.content(k, v)
      end
    end
    
  end
end