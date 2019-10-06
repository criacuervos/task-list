class Task < ApplicationRecord
  
  def self.incomplete
    return Task.where(completed: nil)
  end 
  
  def self.completed
    return Task.where.not(completed: nil)
  end 
end
