require 'rubygems'
require 'twilio-ruby'

module TwilioMessage

	ONE_HOUR=60*60
	ACCOUNT_SID = 'AC2b549023a67d7da4739b29e0ce36b33b'
	AUTH_TOKEN = 'c923af6f6f8d722c440049adeb6f90ac'

	def time_arrival
		time = Time.now+ONE_HOUR
		time.strftime('%H:%M') 
	end	

	def send_text
		@client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
		puts "send out text"
		@client.account.messages.create(
			:from => "+441242305349",
			:to => "+447814430586",
			:body => "Thank you! Your order was placed and will be delivered before #{time_arrival}"
			)
	end


end