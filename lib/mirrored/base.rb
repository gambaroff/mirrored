module Mirrored
  
  class InvalidService < Exception; end
  class ConnectionNotSet < Exception; end
  
  API_URL = {:delicious => 'https://api.del.icio.us/v1/', :magnolia => 'https://ma.gnolia.com/api/mirrord/v1/'}
  
  class Base
    # Sets up the login information for either magnolia or delicious.
    #
    # Usage:
    #   Mirrored::Base.establish_connection(:delicious, 'jnunemaker', 'password')
    #   Mirrored::Base.establish_connection(:magnolia, 'jnunemaker', 'password')
    def self.establish_connection(s, u, p)
      remove_connection
      raise InvalidService unless valid_service?(s)
      @@service = s
      @@connection = Connection.new(api_url, :username => u, :password => p)
    end
    
    # Removes the current connection information
    def self.remove_connection
      @@service, @@connection = nil, nil
    end
    
    def self.valid_service?(s) #:nodoc:
      s = s.nil? ? '' : s
      API_URL.keys.include?(s)
    end
    
    def self.api_url
      API_URL[@@service]
    end
    
    def self.service
      @@service
    end
    
    def self.connection
      @@connection
    end
    
    private
      def ensure_connection_set #:nodoc:
        raise ConnectionNotSet if self.class.connection.nil? || self.class.service.nil?
      end
  end
end