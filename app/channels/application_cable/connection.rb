module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :uuid

    # def connect
    #   # self.current_user = find_verified_user
    #   # self.uuid = SecureRandom.urlsafe_base64
    #   @connection_token = SecureRandom.hex(36)
    #   puts "uuid ==== #{@connection_token}"
    #   return @connection_token
      
    # end
  end
end
