# frozen_string_literal: true

module Admin
  class JobsController < ApplicationController
    def new
      @job = Job.new
    end

    def create
      @job = Job.new(job_params)

      if @job.save
        AddJobToTrelloJob.perform_later @job.id
        redirect_to job_path(@job.id)
        flash[:success] = 'Your job has been created successfully.'
      else
        flash[:error] = @job.errors.full_messages.join('<br>').html_safe
        render 'new'
      end
    end

    private

    def job_params
      params.require(:job).permit(:title, :description, :closing_date)
    end
  end
end
