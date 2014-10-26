require 'net/http'
require 'uri'
require 'active_support/core_ext/hash'

module CafePress
  module PublicAPI
    Error = Class.new(StandardError)

    class Client
      VERSION = '3' # This is an API param
      ENDPOINT = 'http://api.cafepress.com'

      def initialize(key, token)
        @key = key
        @token = token
      end

      def list_deep_by_store(id, options = {})
        options = options.merge(:storeId => id)
        options[:page]     ||= 0
        options[:pageSize] ||= 256

        req = build_request_url('/product.listDeepByStore.cp', options)
        # TODO: handle errors better
        res = Hash.from_xml(Net::HTTP.get(req))
        raise Error, res['help']['exception_message'] if res.include?('help')

        res
      end

      private
      def build_request_url(path, params = {})
        q = params.merge(:v => VERSION, :appKey => @key, :userToken => @token).map do |k,v|
          sprintf '%s=%s', URI.escape(k.to_s), URI.escape(v.to_s)
        end.join('&')

        uri = URI(ENDPOINT)
        uri.path = path
        uri.query = q
        uri
      end
    end
  end
end
