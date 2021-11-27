require 'rails_helper'

describe CarDealership do
  describe '#deliver_car' do
    let(:toyota_dealer) { CarDealership.new }
    context 'Failure' do
      it 'does not deliver a car with the year less than 2000' do
        delivery = toyota_dealer.deliver_car(1999, 'Corolla', 'red', 'Berlin')
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_year)
      end

      it 'does not deliver a car with not available model' do
        delivery = toyota_dealer.deliver_car(2010, 'AYGO', 'red', 'Berlin')
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_model)
      end

      it 'does not deliver a car with not available color' do
        delivery = toyota_dealer.deliver_car(2010, 'Corolla', 'purple', 'Berlin')
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_color)
      end

      it 'does not deliver a car with not available deliver city' do
        delivery = toyota_dealer.deliver_car(2010, 'Corolla', 'red', 'London')
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_deliver_city)
      end
    end

    context 'Success' do
      it 'when all condition are satisfy' do
        delivery = toyota_dealer.deliver_car(2010, 'Corolla', 'red', 'Berlin')
        expect(delivery.success).to eq("A new 2010 red Corolla car is on the way to Berlin!")
        expect(delivery.failure).to eq(nil)
      end
    end
  end
end
