require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Songs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.after_initialize do

        file_name = 'songs'
        path = "app/assets/#{file_name}.pdf"
        print "Searching for songs in #{path}... "
        # Docsplit.extract_text(path, :ocr => false, :output => 'storage/text')

        pdf = File.read("storage/text/#{file_name}.txt")
        from = pdf.index("‫אינדקס שירים‬")
        to = pdf.index("‫אינדקס להקות‬")
        len = to - from

        $songs_index = pdf[from, len].gsub('–','-').gsub(/[^0-9A-Za-zא-ת\s.-]/, '') #remove hidden characters
            .split("\n")
            .select {|s| s.include? '...'}
            .map { |s| create_record(s) }
            .filter {|s| !s[:title].blank? and !s[:artist].blank? }

        puts "#{$songs_index.length} songs found."

        File.open('songs_index.json', 'w') do |f|
          f.puts $songs_index.to_json
        end


        $requests = []
        $requests << 70 << 80 << 90
    end
    
    
    def create_record(s)
        s.squeeze!(".")
        s.gsub!(".", " ")
        s.gsub!(/(\d+)/, ' \1 ')
        s.squeeze!(" ")

        split = s.split(" ")
        page = split[-1]
        bookmark = split[0...-1].join(" ").strip
        split = bookmark.split("-")
        title = prettify(split[0])
        artist = prettify(split[1])

        {   :page => page,
            :title => title,
            :artist => artist,
            :bookmark => bookmark
        }
    end

    def prettify(s) 
      # Remove non alphabetic character and strip both sides whitespaces
      s.to_s.gsub(/[^0-9A-Za-zא-ת\s]/, '').strip
    end


  #   config.after_initialize do

  #     file_name = 'songs'
  #     path = "app/assets/#{file_name}.pdf"
  #     print "Searching for songs in #{path}... "
  #     # Docsplit.extract_text(path, :ocr => false, :output => 'storage/text')

  #     pdf = File.read("storage/text/#{file_name}.txt")
  #     from = pdf.index("‫אינדקס שירים‬")
  #     to = pdf.index("‫אינדקס להקות‬")
  #     len = to - from

  #     $songs_index = pdf[from, len]
  #         .split("\n")
  #         .select {|s| s.include? '...'}
  #         .map { |s| create_record(s) }

  #     puts "#{$songs_index.length} songs found."
  # end
  
  
  # def create_record(s)
  #     s.gsub!(".", "")
  #     split = s.split(" ")
  #     page = split[-2]
  #     split = split[0...-2].join(" ").split("-")
  #     title = prettify(split[0])
  #     artist = prettify(split[1])


  #     if title.blank?
  #       puts "title blank for #{artist}"
  #     end

  #     if artist.blank?
  #       puts "title blank for #{title}"
  #     end

  #     {   :page => page,
  #         :title => title,
  #         :artist => artist
  #     }
  # end

  # def prettify(s) 
  #   # Remove non alphabetic character and strip both sides whitespaces
  #   s.to_s.gsub(/[^0-9A-Za-zא-ת\s]/, '').strip
  # end
    
  end
end
