class Pet < ApplicationRecord
  validates_presence_of :name
  belongs_to :shelter

  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications, dependent: :destroy
end
