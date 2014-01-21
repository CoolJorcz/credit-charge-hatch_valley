class Charge < ActiveRecord::Base
	belongs_to :customer
	validates_presence_of :amount, :currency, :customer_id
end
