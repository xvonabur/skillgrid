class Passport < ActiveRecord::Base
  extend Dragonfly::Model::Validations
  belongs_to :user
  dragonfly_accessor :image

  validates_size_of :image, maximum: 1.megabytes

  # Analyse the format
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif']
end
