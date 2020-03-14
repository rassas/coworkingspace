class Request < ApplicationRecord
  belongs_to :coworking_space

  validates_presence_of :phone, :email, :biography, :name, message: "ne peut pas être vide"
end
