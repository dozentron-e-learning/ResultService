class Api::V1::Result
  include Mongoid::Document

  STRONG_PARAMETERS = %i[
    status
    name
    exercise_id
    submission_id
    classname
    time
    failure_message
    failure_type
    failure_details
  ].freeze

  field :status, type: Symbol
  field :name, type: String
  field :exercise_id, type: String
  field :submission_id, type: String
  field :classname, type: String
  field :time, type: Float
  field :failure_message, type: String
  field :failure_type, type: String
  field :failure_details, type: String

  validates :status, presence: true
  validates :name, presence: true
  validates :classname, presence: true
  validates :exercise_id, presence: true
  validates :submission_id, presence: true

  with_options unless: :success? do |opts|
    opts.validates :failure_message, presence: true
    opts.validates :failure_type, presence: true
    opts.validates :failure_details, presence: true
  end

  private

  def success?
    self.status == :success
  end
end
