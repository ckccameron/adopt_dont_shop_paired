class AddAdoptionColumnToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :adoption, :string
  end
end
