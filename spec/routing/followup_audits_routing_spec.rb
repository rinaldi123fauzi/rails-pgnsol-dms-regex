require "rails_helper"

RSpec.describe FollowupAuditsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/followup_audits").to route_to("followup_audits#index")
    end

    it "routes to #new" do
      expect(get: "/followup_audits/new").to route_to("followup_audits#new")
    end

    it "routes to #show" do
      expect(get: "/followup_audits/1").to route_to("followup_audits#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/followup_audits/1/edit").to route_to("followup_audits#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/followup_audits").to route_to("followup_audits#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/followup_audits/1").to route_to("followup_audits#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/followup_audits/1").to route_to("followup_audits#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/followup_audits/1").to route_to("followup_audits#destroy", id: "1")
    end
  end
end
