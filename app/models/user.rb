class User < ApplicationRecord
  belongs_to :division
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
