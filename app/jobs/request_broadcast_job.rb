class RequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(page, queue, change_queue)
    ActionCable.server.broadcast "requests", {
      page: page,
      queue: queue,
      change_queue: change_queue
    }
  end
end
