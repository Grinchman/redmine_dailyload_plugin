class Period < ActiveRecord::Base
  unloadable

  has_many :issues
end
