class ExportController < ApplicationController

  def csv
    user = User.find_by name: params[:user]
    counter = user.counters.select {|c| c.name == params[:counter]}.first or nil
    if counter == nil
      render :status => 400
      return
    end

    @events = counter.events
    send_data @events.to_csv
  end

end
