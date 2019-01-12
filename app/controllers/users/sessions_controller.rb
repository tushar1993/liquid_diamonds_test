class Users::SessionsController < Devise::SessionsController

	def new
		@title = "Log in for Liquid Diamonds"
	end

	def create
		super
	end

	private

	def after_sign_in_path_for(resource)
		"/products/show"
	end
end
