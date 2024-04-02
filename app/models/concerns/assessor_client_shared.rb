# shared active model code for Assessor and Client
module AssessorClientShared
  extend ActiveSupport::Concern

  enum invitation_status: %i[pending accept declined]

  end
end
