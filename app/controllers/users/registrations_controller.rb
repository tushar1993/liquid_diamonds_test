class Users::RegistrationsController < Devise::RegistrationsController

	def signup
		pass = params[:password] || SecureRandom.hex(10)
		pass_confirm = params[:password_confirmation] || pass
		create {
			flash[:conversion] = true
			redir_url = "/products/show"
			@redir_path = Addressable::URI.parse(redir_url).to_s
		}
	rescue => e
		render 'new'
	end

  protected

	def after_sign_up_path_for(resource)
		@redir_path
	end

	def logout
		sign_out current_user if current_user
	end
end
