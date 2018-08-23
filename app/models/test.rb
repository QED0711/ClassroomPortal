class Test < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :student
    has_many :questions

    def points
        self.points = self.questions.count
    end
end