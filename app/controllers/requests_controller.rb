class RequestsController < ApplicationController

    $by_title = true

    def show
        $by_title = true
        @songs = $songs_index
    end

    def show_by_artist
        $by_title = false
        @songs = $songs_index.sort_by {|s| s['artist']}
        render :controller => 'requests', :action => 'show'
    end

    def request_page
        puts "########### request params: #{params}"
        page = params["page"]
        puts "New Request for page: #{page}"
        queue = Requests.instance.add(page) - 1;

        song = $songs_index.find { |song| song['page'] == page }
        song['queue'] = queue

        RequestBroadcastJob.perform_later(page, queue, nil)
    end
end
