require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "a valid ticket" do
    before :each do
      @scooter = Scooter.new; @scooter.save
      @ticket = Ticket.new(scooter: @scooter, opened_by: 'jah@jah.io')
      expect(@ticket.valid?).to eq true
    end

    it "requires a scooter" do
      @ticket.scooter = nil
      expect(@ticket.valid?).to eq false
    end

    it "requires an opener email" do
      @ticket.opened_by = nil
      expect(@ticket.valid?).to eq false

      #
      # Make sure we have a valid email address here (just basic syntax
      # validation, nothing fancy)
      #
      ["@foo", "foo@", "....", "bar", "q34t;lkj@@"].each do |bad_email|
        @ticket.opened_by = bad_email
        expect(@ticket.valid?).to eq false
      end
    end
  end
end
