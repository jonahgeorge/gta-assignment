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
    @students = Student.all
    
    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:student_id] == student1.id }.length).to eq(1)
    expect(problem.results.select{ |key,value| key[:student_id] == student2.id }.length).to eq(2)
  end

  it "enrollment_constraint" do
    section1 = FactoryGirl.create(:section, current_enrollment: 60)
    section2 = FactoryGirl.create(:section)

    FactoryGirl.create(:student)
    FactoryGirl.create(:student)
    FactoryGirl.create(:student)

    @sections = Section.all
    @students = Student.all
    
    problem = IntegerLinearProgram.new(@students, @sections)
    problem.solve

    expect(problem.results.select{ |key,value| key[:section_id] == section1.id }.length).to eq(2)
    expect(problem.results.select{ |key,value| key[:section_id] == section2.id }.length).to eq(1)
  end

  # FIXME This test fails for some reason
  # it "enrollment_constraint" do
  #   FactoryGirl.create(:section, current_enrollment: 60)

  #   student1 = FactoryGirl.create(:student)
  #   student2 = FactoryGirl.create(:student)

  #   @sections = Section.all
  #   @students = User.students
  #   
  #   problem = IntegerLinearProgram.new(@students, @sections)
  #   problem.solve
  #   problem.print_results
  #   puts problem.results
  # end

end
