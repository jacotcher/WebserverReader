require "smart_pension"


describe "Reading file" do
  context 'Correct filename is given as argument' do
    it "webserver.log" do
      expect(read_file("webserver.log")).to be_true
    end
  end
  context "Incorrect filename is given as argument" do
    it "weberv.log" do
      expect(read_file("weberv.log")).not_to be_true
    end
  end

end
