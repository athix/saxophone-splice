class LandingPagesController < ApplicationController
  layout 'barebones', only: [:motd]

  def index
  end

  def motd
  end

  def about
  end
end
