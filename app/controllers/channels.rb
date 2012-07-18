FuturePatrol.controllers :channels do
  DEFAULT_CHANNEL_IDENTIFIER = 'emily-segal'

  get :index, :map => "/"  do
    @channel     = Arena::Client.channel(DEFAULT_CHANNEL_IDENTIFIER)
    @channels    = @channel['channels']
    @blocks      = @channel['blocks']
    @connections = flatten_connections(@blocks)
    
    render 'channels/index'
  end


  get :show, :with => :id do
    @channel     = Arena::Client.channel(params[:id])
    @channels    = @channel['channels']
    @blocks      = @channel['blocks']
    @connections = flatten_connections(@blocks)
    
    render 'channels/index'
  end
end
