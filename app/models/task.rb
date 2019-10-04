class Task < ApplicationRecord
  
  def self.incomplete
    return Task.where(completed: false)
  end 
  
  def self.completed
    return Task.where(completed: true)
  end 
end
