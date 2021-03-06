class PaymentsController < ApplicationController
  def create #You want might to make actions more specific.
    token = params[:stripeToken] #The token when the form is posted includes the stripe token in the url.
    # Create the charge in stripes servers.  This is what commits the transaction.
    begin
      charge = Stripe::Charge.create(
        :amount => 80000,
        :currency => "usd",
        :source => token,
        :description => params[:stripeEmail]
        )
      rescue Stripe::CardError => e 
        #The card was decline because of number/ccv error, expired error, bank decline, or zip error
        
        body = e.json_body
        err = body[:error]
        flash[:error] = "There was an error in processing your card: #{err[:message]}"
    end
    respond_to do |format|
      format.html { redirect_to "/confirmation" }
      #format.html { redirect_to "/purchase", notice: "Purchase was successfully completed.  We'll be in contact shortly!" }
    end
  end
end