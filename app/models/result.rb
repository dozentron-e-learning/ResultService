class Result
  include Mongoid::Document

  STRONG_PARAMETERS = %i[
    status
    name
    classname
    time
    failure_message
    failure_type
    failure_details
  ].freeze

  field :status, type: Symbol
  field :name, type: String
  field :classname, type: String
  field :time, type: Float
  field :failure_message, type: String
  field :failure_type, type: String
  field :failure_details, type: String

  validates :status, presence: true
  validates :name, presence: true
  validates :classname, presence: true

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
