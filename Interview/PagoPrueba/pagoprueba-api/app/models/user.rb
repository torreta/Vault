# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  belongs_to :profile, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable
  include DeviseTokenAuth::Concerns::User
end
