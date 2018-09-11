require 'oystercard'

STANDARD_DEPOSIT = 10
PENALTY_FARE = 6

describe Oystercard do

  context "Testing balance methods" do

    let (:oystercard) { described_class.new }

    it { is_expected.to have_attributes(:balance => 0) }

    it { should respond_to(:top_up).with(1).argument  }
    it 'tops up oystercard' do
      oystercard.top_up(2)
      expect(oystercard.balance).to eq(2)
    end

    it "Raises an error when card is full" do
      max_balance = Oystercard::MAX_BALANCE
      oystercard.top_up(max_balance)
      expect { oystercard.top_up 1 }.to raise_error("Card has reached its £#{max_balance} limit!")
    end
  end

context "Assumes card balance of £0" do

  let (:oystercard) { described_class.new }

    it 'should prevent travelling with balance less than £1' do
    fare = Oystercard::FARE
    balance = Oystercard::BALANCE
    station = double("station")
    expect { oystercard.touch_in(station) }.to raise_error("Not enough money on card! Your balance is £#{balance}")
    end

  end

  context "Testing touch in/out, journey and entry station methods. Assumes a card balance of £10" do
    let (:oystercard) { described_class.new }

    let ( :station) { double :station }
    before(:each) do
      oystercard.top_up(STANDARD_DEPOSIT)
      oystercard.touch_in(station)
    end

  it 'should deduct fare upon touch out' do
    fare = Oystercard::FARE
    expect { oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-fare)
  end
end

context "Oystercard#fare" do

  let(:trip) { double :journey}
  let(:oystercard) { described_class.new(trip) }


  before(:each) do
    oystercard.top_up(STANDARD_DEPOSIT)
  end

  it "Oystercard#fare returns minimum fare in normal conditions" do
    allow(trip).to receive(:entry_station).and_return('Old Street')
    allow(trip).to receive(:entry_count).and_return(0)
    expect(oystercard.fare).to eq(Oystercard::FARE)
  end

it "charge a penalty fare of £6 if no #touch_in" do
  allow(trip).to receive(:entry_station).and_return(nil)
  expect { oystercard.fare }.to change{ oystercard.balance }.by( - PENALTY_FARE)
  end

it "charge a penalty fare of £6 if no #touch_out.(double touch_in)" do
allow(trip).to receive(:entry_station).and_return("old street")
allow(trip).to receive(:entry_count).and_return(2)
expect { oystercard.fare }.to change{ oystercard.balance }.by( - PENALTY_FARE)
  end
end


end


  # it "Should touch out at journey end" do
  #   oystercard.touch_out(station)
  #   expect(oystercard.in_journey?).to be nil
  # end


  # it 'Remembers the entry station upon touch in' do
  #   expect(oystercard.entry_station).to eq(station)
  # end

  # it 'should set entry_station to nil upon touch out' do
  #   oystercard.touch_out(station)
  #   expect(oystercard.entry_station).to eq(nil)
  # end

  # it 'should store journey details upon touch out' do
  #   hammersmith = double("hammersmith")
  #   oystercard.touch_out(hammersmith)
  #   expect(oystercard.journey).to eq([{ entry_station: station, exit_station: hammersmith}])
  # end
