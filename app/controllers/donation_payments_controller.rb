class DonationPaymentsController < ApplicationController
    def create
        @charity_event = CharityEvent.find(params[:charity_event_id])
        @donation_payment = DonationPayment.create!(amount_cents: params[:amount].to_f * 100, state: 'pending', user: current_user, charity_event: @charity_event)
        authorize @donation_payment
        
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          line_items: [{
            name: @charity_event.title,
            amount: @donation_payment.amount_cents, #same as bellow
            currency: 'eur',
            quantity: 1
          }],
          success_url: donation_payment_url(@donation_payment),
          cancel_url: donation_payment_url(@donation_payment)
        )
      
        @donation_payment.update(checkout_session: session.id)
        redirect_to new_donation_payment_payment_path(@donation_payment)
      end

    def show
        @donation_payment = current_user.donation_payments.find(params[:id])
        authorize @donation_payment
    end
end
