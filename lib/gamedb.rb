
require 'sqlite3'
require 'active_record'


ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	database: ':memory:'
)

ActiveRecord::Schema.define do
	create_table :players, force: true do |t|
		t.string :name
	end
end

class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
end

class Player < ApplicationRecord

end