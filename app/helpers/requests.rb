require 'singleton'
class Requests
    include Singleton

    def initialize
        @requests = [1]
        @index = 0
        @message = nil
    end

    def size 
        @requests.length
    end

    def populate_pool(songs)
        @all_songs = songs.dup
        @pool = songs
    end
    

    def add(page)
        @requests << page unless @requests.include? page
        return @requests.length - @index
    end

    def get()
        puts "-------@pool.length #{@pool.length}"
        @requests[@index]
    end

    def next()

        @index += 1

        puts "-------@pool.length #{@pool.length}"
        if @index >= @requests.length
            if (@pool.nil? or @pool.empty?)
                puts "No more songs. Starting all over again..."
                @pool = @all_songs.dup
            end

            rand_song = @pool.delete(@pool.sample)
            @requests << rand_song[:page.to_s]
            @message = 'שיר אקראי';
        else
            @message = nil;
        end

        $songs_index.each do |song|
            song['queue']-=1 if song['queue'] && song['queue'] >= 0
        end
    end

    def prev()
        puts "-------@pool.length #{@pool.length}"
        @index =  [0, @index - 1].max
        @message = nil;
    end

    def show_message()
        !@message.nil?
    end

    def message()
        @message
    end
end
