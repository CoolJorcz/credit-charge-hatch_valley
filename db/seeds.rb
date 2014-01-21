# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# A successful charge will be paid and not refunded
# A failed charge will be not be paid and not refunded
# A disputed charge will have a disputed date and will be refunded, and will have been paid
def create_customers
	firsts = ['Johny', 'Raj', 'Andrew', 'Mike']
	lasts = ['Flow', 'Jamnis', 'Chung', 'Smith']
	firsts.each_with_index do |first, i|
		Customer.create(first_name: first, last_name: lasts[i])
	end
end

def rand_time(from, to)
	Time.at(from + rand * (to.to_f - from.to_f)).to_i
end

def create_charge(id)
	epoch_in_1998 = 885413447.0
	rand_amount = rand(99999) + 1
	Charge.create(created: rand_time(epoch_in_1998, Time.now),
								 paid: true,
								 amount: (rand(99999)+ 1),
								 currency: 'usd',
								 refunded: false,
								 customer_id: id)
end

def fail(charge)
	charge.update(paid: false)
end

def dispute(charge)
	from = charge.created
	charge.update(paid: false, refunded: true, dispute_date: rand_time(from, Time.now))
end

def charge_customers
	Customer.all.each_with_index do |customer, i|
		id = customer.id
		if id == 1
			8.times { create_charge(id) }
			customer.charges.sample(3).map { |charge| dispute(charge) }
		elsif id == 2
			5.times { create_charge(id) }
			customer.charges.sample(2).map { |charge| dispute(charge) }
		elsif id == 3
			4.times { create_charge(id) }
			customer.charges.sample(3).map { |charge| fail(charge) }
		elsif id == 4
			3.times { create_charge(id) }
			customer.charges.sample(2).map { |charge| fail(charge) }
		end
	end
end

create_customers
charge_customers