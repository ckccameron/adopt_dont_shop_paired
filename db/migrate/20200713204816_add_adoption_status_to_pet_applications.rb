class AddAdoptionStatusToPetApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :status, :string
  end
end
