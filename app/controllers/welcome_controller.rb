include ActionView::Helpers::DateHelper

class WelcomeController < ApplicationController

  def index
    @user = User.find(1)
    @counter = @user.counters.first
    @events_count = Event.where(counter: @counter, timestamp: (Time.now.midnight + 1.hour)..Time.now).count
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

  def update
    user = User.find_by name: params[:user]
    counter = Counter.where(user: user, name: params[:counter]).first
    last = counter.events.last

    events_count = Event.where(counter: counter, timestamp: (Time.now.midnight + 1.hour)..Time.now).count

    cooldown = (last != nil and (last.timestamp > counter.cooldown.minutes.ago))
    ago = last != nil ? time_ago_in_words(last.timestamp) : "an infinitely long time"

    render json: {:cooldown => cooldown, :ago => ago, :events_count => events_count}
  end

end
