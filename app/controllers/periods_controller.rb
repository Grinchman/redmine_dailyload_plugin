class PeriodsController < ApplicationController
  unloadable

  helper :issues

  accept_api_auth :index

  def index
    @issues = Issue.all
    @periods = Period.all
    # respond_to do |format|
    #   format.api
    # end
  end

end
