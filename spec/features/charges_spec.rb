require 'spec_helper'

describe "Charges Index" do

	def rand_time(from, to)
		Time.at(from + rand * (to.to_f - from.to_f)).to_i
	end
	
	before(:each) do

		visit "/charges"
	end

	it "should have three lists" do
		page.should have_content("Successful Charges")
		page.should have_content("Failed Charges")
		page.should have_content("Disputed Charges")
	end

	it "should have 10 successful charges" do
		page.should have_css(".successful li", :count => 10 )
	end

	it "should have 5 failed charges" do
		page.should have_css(".failed li", :count => 5 )
	end

	it "should have failed charges in disputed charges" do
		@charge = Charge.where(paid: false, refunded: true).first
		page.should have_content("#{@charge[:name]}")
	end
end