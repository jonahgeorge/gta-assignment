class RequirementsController < ApplicationController
  before_filter :set_section

  def new
    @requirement = Requirement.new
  end

  def create
    @requirement = Requirement.new(requirement_params)
    @requirement.course_id = @section.course.id
    @requirement.instructor_id = current_user.id

    if @requirement.save
      redirect_to section_path(@section)
    else
      render "new"
    end
  end

  def destroy
    @requirement = Requirement.find(params[:id])
    @requirement.destroy
    redirect_to section_path(@section), notice: 'Requirement was successfully destroyed.'
  end

  private

  def requirement_params
    params[:requirement].permit(:skill_id, :value)
  end

  def set_section
    @section = Section.find(params[:section_id])
  end
end
