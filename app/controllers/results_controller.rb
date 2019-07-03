class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :update, :destroy]

  # GET /results
  def index
    @results = Result.all

    render json: @results
  end

  # GET /results/1
  def show
    render json: @result
  end

  # TODO change to bulk_create to make the difference clearer
  # POST /results
  def create
    #TODO we need to look into the need for transactions in mongodb
    #Result.with_session do |session|
      #session.start_transaction
      @results = []
      result_params = params.fetch(:result, {})

      result_params.each do |rp|
        permitted_rp = rp.permit(*Result::STRONG_PARAMETERS)
        result = Result.new(permitted_rp)
        result.save!

        @results << result
      end

      #session.commit_transaction
    #end

    render json: @results
  end

  # PATCH/PUT /results/1
  def update
    if @result.update(result_params)
      render json: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # DELETE /results/1
  def destroy
    @result.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def result_params
      params.fetch(:result, {}).permit *Result::STRONG_PARAMETERS
    end
end
