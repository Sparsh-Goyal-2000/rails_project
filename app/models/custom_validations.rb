module CustomValidations
    IMAGE_EXTENSION_REGEX = /\.(gif|jpg|png)\Z/i
    IMAGE_ERROR_MESSAGE = 'must be a URL for GIF, JPG or PNG image.'
    PRICE_ERROR_MESSAGE = 'must be greater than discount price'
    
    class UrlValidator < ActiveModel::EachValidator
        def validate_each(record, attribute, value)
        unless value =~ IMAGE_EXTENSION_REGEX
            record.errors.add(attribute, IMAGE_ERROR_MESSAGE)
        end
        end
    end
    
    class ComparePriceValidator < ActiveModel::Validator
        def validate(record)
            return if record.price.nil? || record.discount_price.nil?

            unless record.price > record.discount_price
            record.errors.add :price, PRICE_ERROR_MESSAGE
            end
        end
    end
end