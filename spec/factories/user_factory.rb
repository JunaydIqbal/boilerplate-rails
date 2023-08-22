# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'john@example.com' }
    password { 'admin123' }
    password_confirmation { 'admin123' }
    first_name { 'Klaus' }
    last_name { 'Mikaelson' }
    full_name { 'Abc Def' }
  end

  factory :admin, class: 'User' do
    email { 'admin@example.com' }
    password { 'admin123' }
    password_confirmation { 'admin123' }
    first_name { 'Admin' }
    last_name { 'User' }
    full_name { 'Admin User' }
    role { 'admin' }
  end
end
