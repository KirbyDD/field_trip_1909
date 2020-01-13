class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:id])
  end

  def edit
    @passenger = Passenger.find(params[:id])
  end

  def update
    @passenger = Passenger.find(params[:id])
    @flight = Flight.where(number: params[:number]).first
    @flight.passengers << @passenger
    redirect_to "/passengers/#{@passenger.id}"
  end
end
