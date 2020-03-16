class ExpirationWorker
  include Sidekiq::Worker
  sidekiq_options unique: :while_executing
  sidekiq_options retry: :true
  sidekiq_options :failures => :exhausted

  def perform
    three_mouth_ago_date = Date.today - 3.months
    expired_requests = Request.confirmed.where("confirmed_at < ?", three_mouth_ago_date.beginning_of_day)
    expired_requests.each do |request|
      request.expired!
    end
  end
end
