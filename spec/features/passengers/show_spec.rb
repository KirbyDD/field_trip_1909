require 'rails_helper'

RSpec.describe 'Ass a visitor to a passengers individual page', type: :feature do
  before(:each) do
    @airline = Airline.create!(name: 'American Airlines')
    @flight = @airline.flights.create!(number: "123", date: "01/26/2020", time: "2:00pm", departure_city: "Denver", arrival_city: "Dallas")
    @flight2 = @airline.flights.create!(number: "321", date: "01/27/2020", time: "3:00pm", departure_city: "Los Angeles", arrival_city: "New York")
    @flight3 = @airline.flights.create!(number: "213", date: "01/28/2020", time: "7:00pm", departure_city: "San Diego", arrival_city: "New York")
    @pass = @flight.passengers.create!(name: 'Joe', age: 20)
    @flight2.passengers << @pass
  end

  it "should show passenger's details" do
    visit "/passengers/#{@pass.id}"

    expect(page).to have_content("Name: Joe")
    expect(page).to have_content("123")
    expect(page).to have_content("321")

    expect(page).to_not have_content("213")
  end

  it "should link me to flights show page" do
    visit "/passengers/#{@pass.id}"

    click_on "123"
    expect(current_path).to eq("/flights/#{@flight.id}")
  end
end
