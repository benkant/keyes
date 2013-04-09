require 'sinatra'
require 'poncho'
require 'pry'

require 'keyes'

class Check
  attr_reader :id, :score

  def initialize(id, score)
    @id = id
    @score = score
  end
end

class CheckResource < Poncho::Resource
  param :id, type: :integer
  param :score, type: :integer # TODO: validate 0 < score < 100
end

class CheckCreateMethod < Poncho::JSONMethod

  Keyes::Engine::REQUIRED_PARAMS.each do |field|
    param field, required: true
  end

  def invoke
    # get a Keyes instance and score the request
    fd = Keyes::Engine.new
    score = fd.score(params)

    # id so this can be retrieved later
    id = Random.new.rand(100) # TODO actually store in memory

    CheckResource.new(Check.new(id, score))
  end

  error Keyes::Engine::MissingParam do
    {error: 'Forgetting something?'}
  end
end

post '/checks', &CheckCreateMethod
