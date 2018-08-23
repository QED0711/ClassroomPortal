class Student < ActiveRecord::Base
    belongs_to :teacher
    has_many :tests

    has_secure_password
end