class Api::V1::TouristSitesController < ApplicationController

  def index
    country = params[:country]
    coordinates = GeoapifyService.get_coordinates(country)
    tourist_sites = GeoapifyService.get_tourist_sites(coordinates)

    render json: TouristSiteSerializer.new(tourist_sites)
  end
end