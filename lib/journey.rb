class Journey

  attr_reader :journey, :entry_station, :entry_count

  def initialize
    @journey = []
    @entry_count = 0
  end

  def touch_in(entry_station)
    @entry_count += 1
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @journey << { entry_station: @entry_station, exit_station: exit_station }
    @entry_count = 0
    @entry_station = nil
  end
end
