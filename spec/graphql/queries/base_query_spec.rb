# frozen_string_literal: true

RSpec.describe Queries::BaseQuery do
  
  context "Inclusive Modules" do
    it "should check inclusion of ExecutionErrorResponder" do
      expect(described_class.included_modules).to include(ExecutionErrorResponder)
    end
  end

end
