# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'john@example.com' }
    password { 'admin123' }
    password_confirmation { 'admin123' }
    first_name { 'Klaus' }
    last_name { 'Mikaelson' }
  end
end
