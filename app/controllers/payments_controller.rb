class PaymentsController < ApplicationController
    def new
            @donation_payment = current_user.donation_payments.where(state: 'pending').find(params[:donation_payment_id])
            authorize @donation_payment
    end
end
