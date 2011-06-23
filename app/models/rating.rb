#ref: http://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_numericality_of
class Rating < ActiveRecord::Base
	has_one :user
	
	validates_presence_of :value
	validates_numericality_of :value, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 11, :only_integer => true
end
