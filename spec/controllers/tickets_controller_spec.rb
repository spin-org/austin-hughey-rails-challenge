require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "creating a ticket" do
    before :each do
      @scooter = Scooter.new ; @scooter.save
      @ticket_attributes = {
        opened_by: "jah@jah.io",
        deactivate_scooter: true,
        notes: "Lorem ipsum dolor sit amet...",
        scooter_id: @scooter.id
      }
    end
    it "creates a ticket" do
      post :create, params: { ticket: @ticket_attributes }
      expect(response).to be_success
      expect(JSON.parse(response.body)['scooter_id']).to eq @ticket_attributes[:scooter_id]
    end
  end
end
