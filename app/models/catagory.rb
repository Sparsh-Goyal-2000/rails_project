class Catagory < ApplicationRecord
    
    has_many :subcatagories, class_name: 'Catagory', foreign_key: 'parent_id', dependent: :destroy
    belongs_to :parent, class_name: 'Category', optional: true
    has_many :products, dependent: :restrict_with_error
    has_many :sub_catagories_products, through: :sub_catagories, source: :products

    validates :title, presence: true
    validates :title, uniqueness: {scope: :parent_id}, allow_blank: true
    validate :check_if_parent_id_exists
    validate :check_if_parent_is_not_subcatagory

    private

    def check_if_parent_id_exists
        return if parent_id.nil?

        if parent_id == 0
            errors.add(:parent_id, 'must exist')
        end
    end

    def check_if_parent_is_not_subcatagory
        return if parent_id.nil? || parent_id == 0

        unless Catagory.find(parent_id).parent_id.nil?
            errors.add(:parent_id, 'Sub Catagories can not have any child catagory')
        end
    end
end
