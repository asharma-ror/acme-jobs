module Admin
 class JobsController < ApplicationController
   def new
      @job = Job.new
    end

    def create
      @job = Job.new(job_params)

      if @job.save
        redirect_to job_path(@job.id)
      else
        render 'new'
      end
    end

  private
    def job_params
      params.require(:job).permit(:title, :description, :closing_date)
    end
 end
end
