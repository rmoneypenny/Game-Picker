
class Player < ActiveRecord::Base
	validates :name, presence: true, uniqueness: {case_insensitive: true}
	validates :number, presence: true
end