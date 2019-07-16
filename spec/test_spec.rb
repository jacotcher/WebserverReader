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
      it "Page name should be /help/page/1" do
        expect(visit.page).to eq '/help_page/1'
      end
    end
    context "Address is stored correctly" do
      it "Address should be 126.318.035.038" do
        expect(visit.address).to eq "126.318.035.038"
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

describe "Finding page visit information" do
  context "finding page visits and counting visits to a page from the same address" do
    let (:visit1) {Visit.new("/new_page_7 126.318.035.038")}
    let (:visit2) {Visit.new("/new_page_7 126.318.035.038")}
    it "Should count new page twice" do
      expect(find_page_visits([visit1, visit2])["/new_page_7"]).to eq 2
    end
  end
  context "finding page visits and counting visits from different addresses for the same page" do
    let (:visit1) {Visit.new("/new_page_9 126.318.035.038")}
    let (:visit2) {Visit.new("/new_page_9 126.308.043.829")}
    it "should count new page 9 twice" do
      expect(find_page_visits([visit1, visit2])["/new_page_9"]).to eq 2
    end
  end
  context "finding unique page visits with 2 visits from the same address" do
    let (:visit1) {Visit.new("/new_page_5 126.318.035.038")}
    let (:visit2) {Visit.new("/new_page_5 126.318.035.038")}
    it "Should only count new page 5 once because of the same IP" do
      expect(find_unique_page_visits([visit1, visit2])["/new_page_5"]).to eq 1
    end
  end
  context "finding unique page visits with 2 visits to the same page, but from different address" do
    let (:visit1) {Visit.new("/new_page_15 126.318.035.038")}
    let (:visit2) {Visit.new("/new_page_15 126.909.104.382")}
    it "Should only count new page 5 once because of the same IP" do
      expect(find_unique_page_visits([visit1, visit2])["/new_page_15"]).to eq 2
    end
  end
end
