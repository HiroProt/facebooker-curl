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
      # c = Curl::Easy.new(url.to_s)
      # c.timeout = ENV['FACEBOOKER_TIMEOUT'].to_i rescue c.timeout = nil
      # c.http_post(*to_curb_params(params))
      
      response = Curl::Easy.http_post(url.to_s, *to_curb_params(params)) do |c|
        c.timeout = ENV['FACEBOOKER_TIMEOUT'].to_i rescue c.timeout = nil
      end
      
      Parser.parse(params[:method], response.body_str)
    rescue Errno::ECONNRESET, EOFError
      if attempt == 0
        attempt += 1
        retry
      end
    end
    
    def post_file(params)
      # c = Curl::Easy.new(url.to_s)
      # c.multipart_form_post = true
      # c.timeout = ENV['FACEBOOKER_TIMEOUT'].to_i rescue c.timeout = nil
      # c.http_post(*to_curb_params(params))
      
      response = Curl::Easy.http_post(url.to_s, *to_curb_params(params)) do |c|
        c.multipart_form_post = true
        c.timeout = ENV['FACEBOOKER_TIMEOUT'].to_i rescue c.timeout = nil
      end
      
      Parser.parse(params[:method], response.body_str)
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
      parray = []
      params.each_pair do |k,v|
        parray << (multipart_post_file?(v) ? Curl::PostField.file((k.nil? ? nil : k.to_s), v.filename.to_s) : Curl::PostField.content(k.to_s, v.to_s).to_s)
      end
      parray
    end
    
  end
end