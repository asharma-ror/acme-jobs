# frozen_string_literal: true

class JobsController < ApplicationController
  def index
    @jobs = Job.paginate(page: params[:page], per_page: 10)
  end

  def show
    @job = Job.find(params[:id])
  rescue StandardError
    redirect_to jobs_path,
                flash: {
                  error: "You don't have an access to the requested resource."
                }
  end
end
