class Catagory < ApplicationRecord
    
  has_many :subcatagories, class_name: 'Catagory', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Catagory', optional: true
  has_many :products, dependent: :restrict_with_error
  has_many :sub_catagories_products, through: :sub_catagories, source: :products

  scope :root, -> { where(parent_id: nil) }

  validates :title, presence: true
  validates :title, uniqueness: {scope: :parent_id}, allow_blank: true
  validate :ensure_parent_catagory_exist, if: :parent_id?
  validate :ensure_parent_catagory_is_not_subcatagory, if: :parent_id?

  private

  def ensure_parent_catagory_exist
    if Catagory.find_by(id: parent_id).nil?
      errors.add(:parent_id, 'must exist')
    end
  end

  def ensure_parent_catagory_is_not_subcatagory
    unless Catagory.find_by(id: parent_id).parent.nil?
      errors.add(:parent_id, 'can not be a subcatagory')
    end
  end
end
