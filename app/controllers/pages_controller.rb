
class PagesController < ApplicationController
  def home
  end

  def show
    @page = Requests.instance.get
    @show_message = Requests.instance.show_message()
    @message = Requests.instance.message()
    puts "---Showing page #{@page}"
    @image_path = "final/#{@page}.png"

    
  end

  def next
    # $requests_index += 1
    Requests.instance.next
    RequestBroadcastJob.perform_later(nil, nil, -1)
    redirect_to :controller => "pages", :action => "show"
  end

  def prev
    # $requests_index = [$requests_index - 1, 0].max
    Requests.instance.prev
    RequestBroadcastJob.perform_later(nil, nil, 1)
    redirect_to :controller => "pages", :action => "show"
  end
end
