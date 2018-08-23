class Teacher < ActiveRecord::Base
    has_many :students
    has_many :tests

    has_secure_password
end