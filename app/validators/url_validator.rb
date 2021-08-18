class UrlValidator < ActiveModel::EachValidator
  IMAGE_EXTENSION_REGEX = /\.(gif|jpg|png)\Z/i
  IMAGE_ERROR_MESSAGE = 'must be a URL for GIF, JPG or PNG image.'
  
  def validate_each(record, attribute, value)
    unless value =~ IMAGE_EXTENSION_REGEX
        record.errors.add(attribute, IMAGE_ERROR_MESSAGE)
    end
  end
end