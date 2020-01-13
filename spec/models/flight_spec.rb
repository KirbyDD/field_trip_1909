require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :flight_passengers}
    it {should have_many(:passengers).through(:flight_passengers)}
  end

  describe "methods" do
    it 'Can calculate adults with adults?' do
      airline = Airline.create!(name: 'American Airlines')
      flight = airline.flights.create!(number: "123", date: "01/26/2020", time: "2:00pm", departure_city: "Denver", arrival_city: "Dallas")
      pass1 = flight.passengers.create!(name: 'Joe', age: 20)

      expect(flight.adults?).to eq(1)
    end
    it 'Can calculate minors with minors?' do
      airline = Airline.create!(name: 'American Airlines')
      flight = airline.flights.create!(number: "123", date: "01/26/2020", time: "2:00pm", departure_city: "Denver", arrival_city: "Dallas")
      pass2 = flight.passengers.create!(name: 'Jack', age: 17)

      expect(flight.minors?).to eq(1)
    end
  end
end
