FuturePatrol.helpers do

  # Extracts out a unique list of connections
  # for a given set of blocks.
  def flatten_connections(blocks)
    (blocks.collect do |block|
      block['connections'].collect do |connection|
        {
          :title => connection['channel']['title'],
          :slug  => connection['channel']['slug'],
          :published => connection['channel']['published']
        }
      end
    end).flatten.uniq!
  end

  def channel_active_class(channel, current_channel)
    (channel == current_channel) ? "active" : "inactive"
  end

  def connection_is_displayable?(connection, current_channel_slug)
    (connection[:published] == true) && (connection[:slug] != current_channel_slug)
  end
end
