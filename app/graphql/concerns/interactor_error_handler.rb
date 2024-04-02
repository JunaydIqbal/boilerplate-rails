module InteractorErrorHandler
  extend ActiveSupport::Concern

  private

    def interactors_execution_error(result: nil, status: :unprocessable_entity, code: 422)
      message = encapsulate_error_message(result)
      GraphQL::ExecutionError.new(message, options: { status: status, code: code })
    end

    def encapsulate_error_message(result)
      result = result&.error || result
      error_regex = /error=\"([^\"]+)\"/
      error_match = error_regex.match(result.to_s)
      error_match.present? ? error_match[1] : result
    end

end
