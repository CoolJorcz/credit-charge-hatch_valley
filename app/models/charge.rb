class Charge < ActiveRecord::Base
	belongs_to :customer
	validates_presence_of :amount, :currency, :customer_id
	scope :failed, -> { where(paid: false) }
	scope :successful, -> { where(paid: true) }
	scope :disputed, -> { where('dispute_date > 0 AND refunded = true') }
end
