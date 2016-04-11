class SessionsController < ApplicationController
def new
end

def create
    user = User.find_by(email: params[:session][:email].downcase)
    if !user
      user = User.find_by(name: params[:session][:email].downcase)
    end
    if user && user.authenticate(params[:session][:password])
    	
      #if user.email_confirmed
      	   sign_in user
           redirect_to root_url
	    # else
	    #   flash.now[:error] = 'Please activate your account'
    	#   render 'new'
	    # end
    else
      	flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      	render 'new'
    end
end

def destroy
   sign_out
   redirect_to root_url	
end
end

