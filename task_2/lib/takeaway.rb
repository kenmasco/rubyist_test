require 'rubygems'
require 'twilio-ruby'

ACCOUNT_SID = ENV["TWILIO_ID"]
AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]


class Takeaway
  MENU = {pizza: 8, hamburger: 4.50, cheeseburger: 5, salad: 4, fries: 2.50}

  def place_order(order, expected_total)
    total = 0
    order.each do |item| 
      quantity = item[1] 
      dish = item[0]
      price = MENU[dish]
      total += quantity * price
    end
    if total == expected_total
      send_text("Your order is on the way")
    else 
      raise "Expected total does not match actual total" 
    end
  end

  def send_text(message)
    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

    account = client.account
    text_message = account.sms.messages.create({:from => '+441865922057', :to => '07766778890', :body => message})
    message
  end

end
