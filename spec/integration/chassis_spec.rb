require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Chassis" do

  before :each do
    user ||= ENV["ipmiuser"] || "admin"
    pass ||= ENV["ipmipass"] || "password"
    host ||= ENV["ipmihost"] || "10.0.1.16"
    provider ||= ENV["ipmiprovider"] || "ipmitool"
    @conn = Rubyipmi.connect(user, pass, host, provider)

  end

  after(:each) do
    if ENV['rubyipmi_debug'] == 'true'
      puts "Last Call: #{@conn.chassis.lastcall.inspect}" unless @conn.chassis.lastcall.nil?
    end

  end

  it "test to turn uid light on for 10 seconds" do
    value = @conn.chassis.identify(true, 5)
    sleep(6)
    value.should == true
  end

  it "test to turn uid light on then off" do
    @conn.chassis.identify(true)
    sleep(2)
    @conn.chassis.identify(false).should == true
  end

end