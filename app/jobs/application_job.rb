class ApplicationJob < ActiveJob::Base
  rescue_from(ErrorLoadingSite) do
    retry_job wait: 1.day, queue: :low_priority 
  end  
end
