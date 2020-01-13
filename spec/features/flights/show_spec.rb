require 'rails_helper'

RSpec.describe "As a visitor to an individual flight page", type: :feature do
  before(:each) do
    @airline = Airline.create!(name: 'American Airlines')
    @flight = @airline.flights.create!(number: "123", date: "01/26/2020", time: "2:00pm", departure_city: "Denver", arrival_city: "Dallas")
    @flight2 = @airline.flights.create!(number: "321", date: "01/27/2020", time: "3:00pm", departure_city: "Los Angeles", arrival_city: "New York")
    @pass1 = @flight.passengers.create!(name: 'Joe', age: 20)
    @pass2 = @flight.passengers.create!(name: 'Jack', age: 17)
    @pass3 = Passenger.create!(name: 'Jill', age: 22)
  end

  it 'should show details about the specific airlines' do
    visit "/flights/#{@flight.id}"

    expect(page).to have_content("Airline: American Airlines")
    expect(page).to have_content("Flight Number: 123")
    expect(page).to have_content("Date: 01/26/2020")
    expect(page).to have_content("Time: 2:00pm")
    expect(page).to have_content("Departure City: Denver")
    expect(page).to have_content("Arrival City: Dallas")
    expect(page).to have_content(@pass1.name)
    expect(page).to have_content(@pass2.name)

    expect(page).to_not have_content(@pass3.name)
    expect(page).to_not have_content(@flight2.number)
    expect(page).to_not have_content(@flight2.date)
    expect(page).to_not have_content(@flight2.time)
    expect(page).to_not have_content(@flight2.departure_city)
    expect(page).to_not have_content(@flight2.arrival_city)
  end

  it 'should show how many adults and minors are on the flight' do
    visit "/flights/#{@flight.id}"

    expect(page).to have_content("Adults: 1")
    expect(page).to have_content("Minors: 1")
  end

end
