class ReconfirmationWorker
  include Sidekiq::Worker
  sidekiq_options unique: :while_executing
  sidekiq_options retry: :true
  sidekiq_options :failures => :exhausted

  def perform
    three_mouth_ago_date = Date.today - 3.months
    requests = Request.confirmed.where(
      confirmed_at: three_mouth_ago_date.beginning_of_day..three_mouth_ago_date.end_of_day
    )
    requests.each do |request|
      request.send_reconfirmation_instructions()
    end
  end
end
