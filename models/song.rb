  class Song < ActiveRecord::Base

    belongs_to(:user)


    def sing
    'la di da di'
    end
  end
