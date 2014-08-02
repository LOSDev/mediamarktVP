class MainPageController < ApplicationController
  def index
    @markets = Market.all
  end
end
