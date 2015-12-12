class WelcomeController < ApplicationController

  def index
    @user = User.find(1)
    @counter = @user.counters.first
    @events_count = Event.where(counter: @counter, timestamp: Time.now.midnight..Time.now).count
    # @events_count = @counter.events.size
    @last = @counter.events.last
  end

  def event
    user = User.find_by name: params[:user]
    counter = user.counters.select{|c| c.name == params[:counter]}.first or nil
    if counter == nil or (counter.events.size != 0 and counter.events.last.timestamp > counter.cooldown.minutes.ago)
      flash[:message] = "In cooldown period!"
      redirect_to :action => "index"
      return
    end

    Event.create(:counter => counter, :timestamp => Time.now)
    redirect_to :action => "index"
  end

end
