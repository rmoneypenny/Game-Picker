
class Game < ActiveRecord::Base
	validates :name, presence: true, uniqueness: {case_insensitive: true}
end