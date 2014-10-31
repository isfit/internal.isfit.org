module RequestMacros
	def login_user
		user = FactoryGirl.create(:user, password: 'password')
		post '/sessions', {:login => user.username, :password => 'password'}
	end
	
end