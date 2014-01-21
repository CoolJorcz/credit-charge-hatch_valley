class ChargesController < ApplicationController
	def index
		@failed = Charge.view_create(Charge.failed)
		@success = Charge.view_create(Charge.successful)
		@disputed = Charge.view_create(Charge.disputed)
		@headers = ["Failed", "Disputed", "Successful"]
	end
end