class Teacher < ActiveRecord::Base
    has_many :students
    has_many :tests

    has_secure_password

    def slug
        self.username.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Teacher.find_by(username: slug.gsub("-", " "))
    end
end