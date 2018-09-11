require_relative 'journey'

class Oystercard
    BALANCE = 0
    MAX_BALANCE = 90
    FARE = 1
    PENALTY_FARE = 6
    MAX_ENTRY_COUNT = 1

    attr_reader :balance, :journey

  def initialize(journey = Journey.new)
    @balance = BALANCE
    @journey = journey
  end

  def top_up(top_up_value)
    fail "Card has reached its £#{MAX_BALANCE} limit!" if top_up_value + balance > MAX_BALANCE
    @balance += top_up_value
  end

  def touch_in(station)
    fail "Not enough money on card! Your balance is £#{@balance}" if balance < FARE
    journey.touch_in(station)
  end

  def touch_out(station)
    deduct(FARE)
    journey.touch_out(station)
  end

  def fare
    if journey.entry_station == nil
      deduct(PENALTY_FARE)
    elsif journey.entry_count > 0
      deduct(PENALTY_FARE)
    else
      FARE
    end
  end

  private
  def deduct(money)
    @balance -= money
  end
end


#@max_balance = MAX_BALANCE
# @status = false
#@entry_station


# def in_journey?
#   @entry_station
# end
