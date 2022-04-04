# typed: false
# frozen_string_literal: true

class User < ApplicationRecord
  key :usr

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
