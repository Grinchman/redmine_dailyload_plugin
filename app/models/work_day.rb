class WorkDay < ActiveRecord::Base
  unloadable
  belongs_to :issue
end
