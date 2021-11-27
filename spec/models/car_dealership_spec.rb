require 'rails_helper'

describe CarDealership do
  describe '#deliver_car' do
    let(:toyota_dealer) { CarDealership.new }
    context 'Failure' do
      it 'does not deliver a car with the year less than 2000' do
        delivery = toyota_dealer.deliver_car({ year: 1999, model: 'Corolla', color: 'red', city: 'London'})
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_year)
      end

      it 'does not deliver a car with not available model' do
        delivery = toyota_dealer.deliver_car({ year: 2010, model: 'AYGO', color: 'red', city: 'London'})
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_model)
      end

      it 'does not deliver a car with not available color' do
        delivery = toyota_dealer.deliver_car({ year: 2010, model: 'Corolla', color: 'purple', city: 'London'})
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_color)
      end

      it 'does not deliver a car with not available deliver city' do
        delivery = toyota_dealer.deliver_car({ year: 2010, model: 'Corolla', color: 'red', city: 'London'})
        expect(delivery.success).to eq(nil)
        expect(delivery.failure).to eq(:invalid_deliver_city)
      end
    end

    context 'Success' do
      it 'when all condition are satisfy' do
        delivery = toyota_dealer.deliver_car({ year: 2010, model: 'Corolla', color: 'red', city: 'Berlin'})
        expect(delivery.success).to eq("A new 2010 red Corolla car is on the way to Berlin!")
        expect(delivery.failure).to eq(nil)
      end
    end
  end
end
