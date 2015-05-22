  class User < ActiveRecord::Base
    
    has_many(:chirps)

    include BCrypt

    #getter password
    def password
      Password.new(self.password_hash)
    end

  #setter
    def password = (new_password)
      self.password_hash = Password.create(new_password)
    end

  end
