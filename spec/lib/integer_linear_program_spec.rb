require 'rails_helper'
require 'integer_linear_program'

RSpec.describe IntegerLinearProgram do

  it "fte_constraint" do
    FactoryGirl.create(:section)
    FactoryGirl.create(:section)
    FactoryGirl.create(:section)

    student1 = FactoryGirl.create(:student)
    student2 = FactoryGirl.create(:student, fte: 0.5)

    @sections = Section.all
    @students = User.students

    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:student_id] == student1.id }.length).to eq(1)
    expect(problem.results.select{ |key,value| key[:student_id] == student2.id }.length).to eq(2)
  end

  it "three person enrollment_constraint" do
    section1 = FactoryGirl.create(:section, current_enrollment: 60)
    section2 = FactoryGirl.create(:section)

    FactoryGirl.create(:student)
    FactoryGirl.create(:student)
    FactoryGirl.create(:student)

    @sections = Section.all
    @students = User.students

    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:section_id] == section1.id }.length).to eq(2)
    expect(problem.results.select{ |key,value| key[:section_id] == section2.id }.length).to eq(1)
  end

  it "two person enrollment_constraint" do
    FactoryGirl.create(:section, current_enrollment: 60)

    student1 = FactoryGirl.create(:student)
    student2 = FactoryGirl.create(:student)

    @sections = Section.all
    @students = User.students

    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:student_id] == student1.id }.length).to eq(1)
    expect(problem.results.select{ |key,value| key[:student_id] == student2.id }.length).to eq(1)
  end

  it "skill_constraint where student is qualified" do
    skill = FactoryGirl.create(:skill)
    student = FactoryGirl.create(:student)
    student.experiences.create! skill_id: skill.id, value: 2
  
    section = FactoryGirl.create(:section)
    section.course.requirements.create! skill_id: skill.id, instructor_id: section.instructor.id, value: 2
 
    @sections = Section.all
    @students = User.students
  
    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:section_id] == section.id }.length).to eq(1)
    expect(problem.results.select{ |key,value| key[:student_id] == student.id }.length).to eq(1)
  end

  it "skill_constraint where student is unqualified" do
    skill = FactoryGirl.create(:skill)
    student = FactoryGirl.create(:student)
  
    section = FactoryGirl.create(:section)
    section.course.requirements.create! skill_id: skill.id, instructor_id: section.instructor.id, value: 2
 
    @sections = Section.all
    @students = User.students
  
    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:section_id] == section.id }.length).to eq(0)
    expect(problem.results.select{ |key,value| key[:student_id] == student.id }.length).to eq(0)
  end

  it "skill_constraint where one student is unqualified and the other is qualified" do
    skill = FactoryGirl.create(:skill)
    student1 = FactoryGirl.create(:student)
    student2 = FactoryGirl.create(:student)
    student2.experiences.create! skill_id: skill.id, value: 2
   
    section = FactoryGirl.create(:section)
    section.course.requirements.create! skill_id: skill.id, instructor_id: section.instructor.id, value: 2
 
    @sections = Section.all
    @students = User.students
  
    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:section_id] == section.id }.length).to eq(1)
    expect(problem.results.select{ |key,value| key[:student_id] == student1.id }.length).to eq(0)
    expect(problem.results.select{ |key,value| key[:student_id] == student2.id }.length).to eq(1)
  end

end
