require "rails_helper"

RSpec.describe Supervisor, type: :model do
  describe "#role" do
    subject(:supervisor) { create :supervisor }

    it { expect(supervisor.role).to eq "Supervisor" }
  end

  describe "#active_volunteers" do
    subject { supervisor.active_volunteers }
    let(:supervisor) { create :supervisor }
    let!(:active_and_associated) { create :supervisor_volunteer, supervisor: supervisor }
    let!(:inactive_and_associated) { create :supervisor_volunteer, :inactive }
    let!(:active_and_not_associated) { create :supervisor_volunteer }

    it "excludes non-active volunteers" do
      expect(subject).to include(active_and_associated)
      expect(subject).not.to include(inactive_and_associated)
      expect(subject).not.to include(active_and_not_associated)
    end
  end
end
