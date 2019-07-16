require "smart_pension"


describe "Reading file" do
  context 'Correct filename is given as argument and file exists' do
    it "webserver.log" do
      expect(read_file("webserver.log")).to be_an_instance_of(Array)
    end
  end
  context "Incorrect filename is given as argument/file does not exist" do
    it "weberv.log" do
      expect(read_file("weberv.log")).to be false
    end
  end

end
