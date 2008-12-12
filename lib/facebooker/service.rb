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
      call_url = url
      response = Curl::Easy.http_post(call_url.to_s, to_curb_params(params)).body_str
      result = Parser.parse(params[:method], response)
    rescue Errno::ECONNRESET, EOFError
      if attempt == 0
        attempt += 1
        retry
      end
    end
    
    def post_file(params)
      c = Curl::Easy.new(url.to_s)
      c.multipart_form_post = true
      #c.on_debug {|type, data| puts "#{type}, #{data}"}
      ps = to_curb_params(params)
      c.http_post(*ps)
      puts "RESPONSE: #{c.body_str}"
      Parser.parse(params[:method], c.body_str)
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
        parray << (multipart_post_file?(v) ? Curl::PostField.file((k.nil? ? nil : k.to_s), v.filename.to_s) : Curl::PostField.content(k.to_s, v.to_s))
      end
      parray
    end
    
  end
end