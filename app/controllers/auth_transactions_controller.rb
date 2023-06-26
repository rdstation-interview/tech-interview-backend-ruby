class AuthTransactionsController < ApplicationController
  before_action :validate_amount

  def create
    card = Card.find_by(card_number: payment_params[:card_number])

    if card
      render json: { message: "OK" }, status: :created     
    else
      render json: { message: "Card not found" }, status: :unprocessable_entity
    end
  end

  private
  def payment_params
    params.permit(:amount, :card_number)
  end

  def validate_amount
    if payment_params[:amount].to_f > 1000.0
      render json: { message: "Not enough funds" }, status: :unprocessable_entity and return
    end
  end
end
