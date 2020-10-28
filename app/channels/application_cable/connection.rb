module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_chef

    def connect
      self.current_chef = find_verified_chef
    end

    private
      def find_verified_chef
        if verified_chef = Chef.find_by(id: cookies.encrypted[:chef_id])
          verified_chef
        else
          reject_unauthorized_connection
        end
      end
  end
end
