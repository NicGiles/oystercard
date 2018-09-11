require 'station'

describe Station do

  let(:station) { described_class.new("Angel", 1) }

  it "On initialisation name stored in instance variable." do
    expect(station.name).to eq("Angel")
  end

  it "On initialisation zone stored in instance variable." do
    expect(station.zone).to eq(1)
  end

  it "On initialisation zone and name stored in instance variable." do
    expect(station.station_info).to eq({ name: "Angel", zone: 1 })
  end

end
