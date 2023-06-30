require 'rails_helper'

RSpec.describe 'Issuer Integration', type: :request do
  xdescribe '/api/auth_transactions' do
    context 'when the transaction amount is less than $1k' do
      it 'approves the transaction' do
        payload = {
          amount: 700,
          card_number: '4321123443211234',
        }

        post '/api/auth_transactions', params: payload

        expect(response.code).to eq 201
        expect(JSON.parse(response.body, symbolize_names: true)).to eq message: 'OK'
      end      
    end

    context 'when the transaction amount is equal to $1k' do
      it 'approves the transaction' do
        payload = {
          amount: 1_000,
          card_number: '4321123443211234',
        }

        post '/api/auth_transactions', params: payload

        expect(response.code).to eq 201
        expect(JSON.parse(response.body, symbolize_names: true)).to eq message: 'OK'
      end      
    end

    context 'when the transaction amount is greater than $1k' do
      it 'declines the transaction' do
        payload = {
          amount: 2_000,
          card_number: "4321123443211234",
        }

        post '/api/auth_transactions', params: payload

        expect(response.code.to_i).to eq 422
        expect(JSON.parse(response.body, symbolize_names: true)).to eq message: 'Not enough funds'
      end
    end
  end
end