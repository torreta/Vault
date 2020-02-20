# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  belongs_to :profile, dependent: :destroy
  
  has_many :bank_accounts
  has_many :banks, through: :bank_accounts

  has_many :sent_transactions, :class_name => 'Transaction', :foreign_key => 'sender_id'
  has_many :received_transactions, :class_name => 'Transaction', :foreign_key => 'receiver_id'

  devise :database_authenticatable, :registerable,
         :recoverable
  include DeviseTokenAuth::Concerns::User
end
