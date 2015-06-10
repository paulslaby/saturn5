require 'spec_helper'

describe RootController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'#, use_route: :root
      expect(response).to be_success
    end
  end

end
