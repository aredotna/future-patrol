FuturePatrol.controllers :channels do
  DEFAULT_CHANNEL_IDENTIFIER = 'semblance'

  before do
    # ...
  end

  get :index, :map => "/"  do
    @channel  = Arena::Client.channel(DEFAULT_CHANNEL_IDENTIFIER)
    @channels = @channel['channels']
    @blocks   = @channel['blocks']
    
    render 'channels/show'
  end


  get :show, :map => "/:id" do
    @channel  = Arena::Client.channel(params[:id])
    @channels = @channel['channels']
    @blocks   = @channel['blocks']
    
    if request.xhr?
      render 'channels/show', :layout => false
    else
      render 'channels/show'
    end
  end
end
