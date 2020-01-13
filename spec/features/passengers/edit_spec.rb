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

  it "should add passenger to a flight" do
    visit "/passengers/#{@pass.id}"
    expect(page).to_not have_content("213")

    click_on "Add Flight"
    expect(current_path).to eq("/passengers/#{@pass.id}/edit")

    fill_in :number, with: "213"

    click_on "Submit"
    expect(current_path).to eq("/passengers/#{@pass.id}")
    expect(page).to have_content("213")
  end
end
