Rails.application.routes.draw do
  root 'requests#show'
  get 'byArtist' => 'requests#show_by_artist'
  get 'show' => 'pages#show'
  get 'songs/next' => 'pages#next'
  get 'songs/prev' => 'pages#prev'
  post 'request/:page' => 'requests#request_page'
  # post 'request' => 'requests#request_page'

  # mount ActionCable.server, at: '/cable'

    
end
