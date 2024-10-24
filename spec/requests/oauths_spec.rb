require 'rails_helper'

RSpec.describe "Oauths", type: :request do
  describe "GET /oauth" do
    it "returns http success" do
      skip "このテストはスキップします"
      get "/oauths/oauth"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /callback" do
    it 'httpの成功を返す', skip: "このテストはスキップします" do
      get "/oauths/callback"
      expect(response).to have_http_status(:success)
    end
  end
end
