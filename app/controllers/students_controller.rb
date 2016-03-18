class StudentsController < ApplicationController
	def new
		@student = Student.new
	end

	def create

		@student = Student.new(student_params)

		# puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		# puts params[:student][:photo]
		
		respond_to do |format|
			if @student.save
 
				 image="/home/varun/Apps/cfi_app/public/assets/students/#{@student.id}/original/#{@student.photo_file_name}"
				 puts image
				 hash = Cloudinary::Uploader.upload("#{image}")
				
				 face_url = hash["url"]


				 face_api(face_url,@student)

				format.html { redirect_to action: :show, id: @student.id, notice: 'Student successfully created' }
			else
				format.html { render action: "new" }
			end
		end
	end
	
	def show
		@student = Student.find(params[:id])
		
	end

	def face_api(face_url,student)

		api_key="edf054c4879fff4ce8ddbae073113794"
		api_secret="HcR0p_mkAiCBxXr3pVXV4AC6otDk6RNG"

		@response_detect = RestClient.get "https://apius.faceplusplus.com/v2/detection/detect?api_secret=#{api_secret}&api_key=#{api_key}&url=#{face_url}"

		name=student.name
		class_name=student.class_name

		@result = JSON.parse @response_detect
		face_id = @result["face"][0]["face_id"]

		@response_person = RestClient.get "https://apius.faceplusplus.com/v2/person/create?api_key=#{api_key}&api_secret=#{api_secret}&tag=#{name}&face_id=#{face_id}&group_name=Class#{class_name}"			

				10.times do
					puts
				end
		@res = JSON.parse @response_person

		person_id = @res["person_id"]
				puts person_id

		update_student(student,person_id,face_id,face_url)
		
	end

	def update_student(student,person_id,face_id,face_url)
		if student.update_attributes(:person_id => person_id)
			puts "Update Succesfull"
			@face = student.faces.create(face_id: face_id,face_url: face_url)
		end

		
	end





	private

	def student_params
		params.require(:student).permit(:name, :roll_num,:class_name,:photo)
	end
end
