# Clear the db before inserting
Teacher.all.each do |teacher|
    teacher.delete
end

Student.all.each do |student|
    student.delete
end

Test.all.each do |tst|
    tst.delete
end

Question.all.each do |question| 
    question.delete
end

# Insert new data

t1 = Teacher.create(name: "Quinn", password: "123")
t2 = Teacher.create(name: "Betsy", password: "123")
t3 = Teacher.create(name: "Sho", password: "123")

s1 = Student.create(name: "Tim", password: "123")
s2 = Student.create(name: "Tom", password: "123")
s3 = Student.create(name: "Tang", password: "123")
s4 = Student.create(name: "Bill", password: "123")
s5 = Student.create(name: "Bob", password: "123")
s6 = Student.create(name: "Bush", password: "123")
s7 = Student.create(name: "Nancy", password: "123")
s8 = Student.create(name: "Mancy", password: "123")
s9 = Student.create(name: "Jancy", password: "123")

tst1 = Test.create(title: "Notes")
tst2 = Test.create(title: "Clefs")
tst3 = Test.create(title: "Intervals")
tst4 = Test.create(title: "Rhythm")
 
q1 = Question.create(question: "quesiton 1", answer: "answer 1")
q2 = Question.create(question: "quesiton 2", answer: "answer 2")
q3 = Question.create(question: "quesiton 3", answer: "answer 3")
q4 = Question.create(question: "quesiton 4", answer: "answer 4")
q5 = Question.create(question: "quesiton 5", answer: "answer 5")
q6 = Question.create(question: "quesiton 6", answer: "answer 6")
q7 = Question.create(question: "quesiton 7", answer: "answer 7")
q8 = Question.create(question: "quesiton 8", answer: "answer 8")
q9 = Question.create(question: "quesiton 9", answer: "answer 9")
q10 = Question.create(question: "quesiton 10", answer: "answer 10")
q11 = Question.create(question: "quesiton 11", answer: "answer 11")
q12 = Question.create(question: "quesiton 12", answer: "answer 12")

# Create relations

tst1.questions = [q1, q2, q3]
tst2.questions = [q4, q5, q6]
tst3.questions = [q7, q8, q9]
tst4.questions = [q10, q11, q10]

t1.students = [s1, s2, s3]
t2.students = [s4, s5, s6]
t3.students = [s7, s8, s9]

t1.tests = [tst1, tst2]
t2.tests = [tst3]
t3.tests = [tst4]

# Save all to db

t1.save
t2.save
t3.save

s1.save
s2.save
s3.save
s4.save
s5.save
s6.save
s7.save
s8.save
s9.save

tst1.save
tst2.save
tst3.save
tst4.save

q1.save
q2.save
q3.save
q4.save
q5.save
q6.save
q7.save
q8.save
q9.save
q10.save
q11.save


