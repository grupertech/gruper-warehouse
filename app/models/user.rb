class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end