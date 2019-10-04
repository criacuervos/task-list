class Task < ApplicationRecord
  #not sure if right ????????
  def self.incomplete
    Task.find_by(completed: false)
  end 
  
  def self.completed
    where(completed: true)
  end 
end
