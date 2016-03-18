class StudentsController < ApplicationController
	def new
		@student = Student.new
	end

	def create
		@student = Student.new(student_params)
		puts @student
		respond_to do |format|
			if @student.save
				format.html { redirect_to new_student_path, notice: 'Student successfully created' }
			else
				format.html { render action: "new" }
			end
		end
	end
	private

	def student_params
		params.require(:student).permit(:name, :roll_num,:class_name)
	end
end
