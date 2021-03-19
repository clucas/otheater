require 'rails_helper'

RSpec.describe "VenueLayouts", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/venue_layouts/create"
      expect(response).to have_http_status(:success)
    end
  end

end
