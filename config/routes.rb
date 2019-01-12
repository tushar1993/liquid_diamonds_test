Rails.application.routes.draw do
	root to: "products#show"

	devise_options_for_users = {
		:controllers => {
			:sessions => 'users/sessions',
			:passwords => 'users/passwords'
		},
		:path_names => {
			:sign_in => 'signin',
			:sign_up => 'signup',
			:sign_out => 'signout'
		},
		:skip => [
			:registrations
		]
	}
	devise_for :users, devise_options_for_users
	devise_scope :user do
		# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
		#root to: "home#index"
		get 'users/signin' => 'users/sessions#new'
		post 'users/signin' => 'users/sessions#create'
		get 'users/signup' => 'users/registrations#new'
		post 'users/signup' => 'users/registrations#signup'
		get 'users/signout', :to => 'devise/sessions#destroy', :via => [:delete]
	end
	resource :products do
		collection do
			get 'show'
		end
	end
end
