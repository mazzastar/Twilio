require 'rubygems'
require 'twilio-ruby'

module TwilioMessage

	ONE_HOUR=60*60
	account_sid = 'AC2b549023a67d7da4739b29e0ce36b33b'
	auth_token = 'c923af6f6f8d722c440049adeb6f90ac'
	@client = Twilio::REST::Client.new account_sid, auth_token

	def time_arrival
		time = Time.now+ONE_HOUR
		time.strftime('%H:%M') 
	end	

	def send_text
		puts "send out text"
		@client.account.messages.create(
			:from => "+441242305349",
			:to => "+447814430586",
			:body => "Thank you! Your order was placed and will be delivered before #{time_arrival}"
			)
	end


end