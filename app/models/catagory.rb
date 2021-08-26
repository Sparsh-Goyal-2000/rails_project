class Catagory < ApplicationRecord
    
  has_many :subcatagories, class_name: 'Catagory', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Catagory', optional: true
  has_many :products, dependent: :restrict_with_error
  has_many :sub_catagories_products, through: :sub_catagories, source: :products

  validates :title, presence: true
  validates :title, uniqueness: {scope: :parent_id}, allow_blank: true
end
