require 'rubygems'
require 'twilio-ruby'
 
# # Get your Account Sid and Auth Token from twilio.com/user/account
# account_sid = 'AC36b0a7b7aef8d0cab1605860a40edc8c'
# auth_token = 'cf3269478f796d5af3d16a47d10a3fed'
# @client = Twilio::REST::Client.new account_sid, auth_token
 
# message = @client.account.sms.messages.create(:body => "Jenny please?! I love you <3",
#     :to => "+447814430586",     # Replace with your phone number
#     :from => "+441562612030")   # Replace with your Twilio number
# puts message.sid


class TestTwilio

	ONE_HOUR=3600

	def initialize 
		account_sid = 'AC6b543fe3489268bcd6a73496cb1a5a9c'
		auth_token = '45e4638bbf3cb2bd05dc9534920d53bc'
		@client = Twilio::REST::Client.new account_sid, auth_token
	end

	def time_arrival
		time = Time.now+ONE_HOUR
		time.strftime('%H:%M') 
	end

	def send_text(info)
		@client.account.messages.create(
			:from => "+441562612030",
			:to => "+447814430586",
			:body => "Thank you! Your order was placed and will be delivered before #{time_arrival}"
			)
	end

end

 # puts (TestTwilio.new).time_arrival
 
