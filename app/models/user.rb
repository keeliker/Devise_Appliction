class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable 信箱驗證, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  include Gravtastic
	gravtastic

  has_many :ideas
  has_one :avatar , foreign_key: "user_id" 
end
