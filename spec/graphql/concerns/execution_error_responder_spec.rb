# frozen_string_literal: true

require 'rails_helper'

class ErrorGenerator
  include ExecutionErrorResponder

  def shootout!
    execution_error(message: 'Boom!')
  end
end

RSpec.describe ExecutionErrorResponder do
  let(:error_obj) { ErrorGenerator.new.shootout! }

  context 'Methods' do
    it 'should instantiate GraphQL::ExecutionError class' do
      expect(error_obj.is_a?(GraphQL::ExecutionError)).to be(true)
      expect(error_obj.message).to eq('Boom!')
    end
  end
end
