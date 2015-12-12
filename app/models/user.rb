class User < ActiveRecord::Base
  has_many :counters
end
