class Test < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :student
    has_many :questions

    def points
        self.points = self.questions.count
    end

    def slug
        self.title.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Test.find_by(title: slug.gsub("-", " "))
    end
end