require "rails_helper"

RSpec.describe DakTemplatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/dak_templates").to route_to("dak_templates#index")
    end

    it "routes to #new" do
      expect(get: "/dak_templates/new").to route_to("dak_templates#new")
    end

    it "routes to #show" do
      expect(get: "/dak_templates/1").to route_to("dak_templates#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/dak_templates/1/edit").to route_to("dak_templates#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/dak_templates").to route_to("dak_templates#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/dak_templates/1").to route_to("dak_templates#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/dak_templates/1").to route_to("dak_templates#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/dak_templates/1").to route_to("dak_templates#destroy", id: "1")
    end
  end
end
