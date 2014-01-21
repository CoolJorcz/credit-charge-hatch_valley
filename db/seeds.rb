# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_customers
end

def rand_time(from = 0.0, to = Time.now)
	Time.at(from + rand * (to.to_f - from.to_f) )
end

def rand_dispute_date
end

def create_charge
end

def success
end

def fail
end

def dispute
end

def charge_customers
end