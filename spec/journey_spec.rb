require 'journey'

describe Journey do

  it "Journey#touch_in" do
    station = double("station")
  expect(subject.touch_in(station)).to eq(station)
  end

  it "Journey#touch_out" do
    station = double(station)
    subject.touch_in("entry_station")
    expect(subject.touch_out("exit_station")).to eq(nil)
  end

  it 'should store journey details upon touch out' do
    hammersmith = double("hammersmith")
    old_street = double("old_street")
    subject.touch_in(hammersmith)
    subject.touch_out(old_street)
    expect(subject.journey).to eq([{ entry_station: hammersmith, exit_station: old_street}])
  end

end
