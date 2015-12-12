class Event < ActiveRecord::Base
  belongs_to :counter

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['Timestamp']
      all.each do |event|
        csv << [event.timestamp]
      end
    end
  end
end
