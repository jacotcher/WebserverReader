require "smart_pension"

describe "Reading file" do
  context 'Correct filename is given as argument and file exists' do
    it "webserver.log" do
      expect(read_file("webserver.log")).to be_an_instance_of(Array)
    end
  end
  context "Incorrect filename is given as argument/file does not exist" do
    it "weberv.log" do
      expect(read_file("weberv.log")).to be_nil
    end
  end
  context "No argument is given as the filename" do
    it nil do
      expect(read_file(nil)).to be_nil
    end
  end
end

describe Visit do
  describe "Creating a visit" do
    # let(:visit) {FactoryGirl.create(:visit, page: '/help_page/1', address: '126.318.035.038')}
    let (:visit) {Visit.new("/help_page/1 126.318.035.038")}
    context "Page is stored correctly" do
      it "/help_page/1 126.318.035.038" do
        expect(visit.page).to start_with '/he'
        expect(visit.page).to end_with '/1'
      end
    end
    context "Address is stored correctly" do
      it "/help_page/1 126.318.035.038" do
        expect(visit.address).to start_with '126'
        expect(visit.address).to end_with '038'
      end
    end
  end
end

describe "Sort and print test" do
  context "sorting a and printing a hash" do
    let(:visit) {{"j" => 5, "p" => 0, "o" => 2}}
    it "Sort and return hash" do
      expect(sort_and_print(visit)).to eq ({"j"=>5, "o"=>2, "p"=>0})
    end
  end
end
