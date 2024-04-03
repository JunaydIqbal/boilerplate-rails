# :Base Interactor for including the Interactor Module:

class BaseInteractor
  include Interactor

  def generate_blob!(file)
    return if file.blank?

    ActiveStorage::Blob.create_and_upload!(
      io: file,
      filename: file.original_filename,
      content_type: file.content_type
    )
  end
end