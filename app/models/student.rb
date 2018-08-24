class Student < ActiveRecord::Base
    belongs_to :teacher
    has_many :tests

    has_secure_password

    def slug
        self.username.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Student.find_by(username: slug.gsub("-", " "))
    end
end