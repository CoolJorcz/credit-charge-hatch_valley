require 'spec_helper'

describe "Charges Index" do

	def rand_time(from, to)
		Time.at(from + rand * (to.to_f - from.to_f)).to_i
	end
	
	before(:each) do

		visit "/charges"

		assert(:charge) { Charge.create!(Charge.create(created: rand_time(885413447.0, Time.now),
								 paid: false,
								 amount: (rand(99999)+ 1),
								 currency: 'usd',
								 refunded: true,
								 dispute_date: Time.now,
								 customer_id: 1))}
	end

	it "should have three lists" do
		page.should have_content("Successful Charges")
		page.should have_content("Failed Charges")
		page.should have_content("Disputed Charges")
	end

	it "should have 10 successful charges" do
		page.
	end

	it "should have 5 failed charges" do

	end

	it "should have failed charges in disputed charges" do

	end
end