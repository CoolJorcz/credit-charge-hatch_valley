class Charge < ActiveRecord::Base
	belongs_to :customer
	validates_presence_of :amount, :currency, :customer_id
	scope :failed, -> { where(paid: false) }
	scope :successful, -> { where(paid: true) }
	scope :disputed, -> { where('dispute_date > 0 AND refunded = true') }
	after_create :define_created

	def self.view_create(type)
		view_array = []
		type.each do |charge|
			view = {}
			
			first = charge.customer.first_name
			last = charge.customer.last_name
			view[:name] = name_maker(first, last)
			view[:amount] = money_maker(charge)
			view[:date] = date_maker(charge)
			view_array << view
		end
		view_array
	end

	# For actual charge creation when data not seeded in
	# def define_created
	# 	self.update(created: Time.now.to_i )
	# end

	private

	def self.name_maker(first, last)
		"#{first} #{last}"
	end

	def self.money_maker(charge)
		if charge.currency == 'usd'
			"$#{charge.amount.to_f / 100}"
		else
			#TODO other currencies
		end
	end

	def self.date_maker(charge)
		date = charge.dispute_date != 0 ? charge.dispute_date : charge.created
		Time.at(date).to_date
	end
end
