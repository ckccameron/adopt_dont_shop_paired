module ApplicationsHelper

  def group
    pet_app_array = PetApplication.all
    pet_app_array.group_by do |pet_app|
      pet_app.application_id
    end
  end


end
#
# arr = PetApplication.all
# z = arr.group_by { |pet_app| pet_app.application_id }
#
# z.each do |k,v|
#   app = Application.find(k)
#   puts app.name
#   puts app.address
#   puts app.state
#   puts app.zip
#   puts app.phone_number
#   puts app.description
#
#   v.each do |p_id|
#     pet = Pet.find(p_id.pet_id)
#     puts pet.name
#   end
# end
