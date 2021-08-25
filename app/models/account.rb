class Account < ApplicationRecord
  belongs_to :common_account,
    polymorphic: true, 
    autosave: true, 
    class_name: 'Person', 
    dependent: :destroy, 
    primary_key: 'id', 
    foreign_key: 'person_id',
    inverse_of: :account,
    touch: true,
    validate: true,
    optional: true


#   5,6,7,8,3,4,11,12,1,2,10,9
#   after_save :show_output_1
#   after_save :show_output_2
#   before_save :show_output_3
#   before_save :show_output_4
#   before_validation :show_output_5
#   before_validation :show_output_6
#   after_validation :show_output_7
#   after_validation :show_output_8
#   after_destroy_commit :show_output_9
#   after_commit :show_output_10
#   before_create :show_output_11
#   before_create :show_output_12

#   def show_output_1
#     puts '1'
#   end

#   def show_output_2
#     puts '2'
#   end

#   def show_output_3
#     puts '3'
#   end

#   def show_output_4
#     puts '4'
#   end

#   def show_output_5
#     puts '5'
#   end

#   def show_output_6
#     puts '6'
#   end

#   def show_output_7
#     puts '7'
#   end

#   def show_output_8
#     puts '8'
#   end

#   def show_output_9
#     puts '9'
#   end

#   def show_output_10
#     puts '10'
#   end

#   def show_output_11
#     puts '11'
#   end

#   def show_output_12
#     puts '12'
#   end
end