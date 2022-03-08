require 'rails_helper'

describe "Holiday" do

  it "isn't made up" do

    data = {:date => "2022-06-20", name: "Juneteenth"}
    holiday = Holiday.new(data)
    expect(holiday).to be_an_instance_of(Holiday)
  end

  it "has accessible data" do
    data = {:date => "2022-06-20", name: "Juneteenth"}
    holiday = Holiday.new(data)
    expect(holiday.date).to eq("2022-06-20")
    expect(holiday.name).to eq("Juneteenth")
  end
end
