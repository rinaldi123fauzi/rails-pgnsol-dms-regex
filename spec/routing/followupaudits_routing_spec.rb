require "rails_helper"

RSpec.describe FollowupauditsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/followupaudits").to route_to("followupaudits#index")
    end

    it "routes to #new" do
      expect(get: "/followupaudits/new").to route_to("followupaudits#new")
    end

    it "routes to #show" do
      expect(get: "/followupaudits/1").to route_to("followupaudits#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/followupaudits/1/edit").to route_to("followupaudits#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/followupaudits").to route_to("followupaudits#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/followupaudits/1").to route_to("followupaudits#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/followupaudits/1").to route_to("followupaudits#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/followupaudits/1").to route_to("followupaudits#destroy", id: "1")
    end
  end
end
