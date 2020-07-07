class AddDefaultValueToAdoptionStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default :pets, :adoption_status, true 
  end
end
