require './config/environment'
#require_relative '../../config/environment'  # for docker
require 'swagger/blocks'
require 'sinatra'
require 'sinatra/base'
require 'json'
require 'fsp_harvester'
# DO NOT change the order of loading below.  The files contain executable code that builds the overall configuration before this module starts
require_relative './configuration.rb'
require_relative './models.rb'
require_relative './routes.rb'

class ApplicationController < Sinatra::Application
  include Swagger::Blocks

  set :bind, '0.0.0.0'
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

    
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :cross_origin
  end

  # routes...  
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'FAIR Signposting Harvester Server'
      key :description, 'Serves metadata gathered by the FAIR Signposting Harvester'
      key :termsOfService, 'https://example.org'
      contact do
        key :name, 'Mark D. Wilkinson'
      end
      license do
        key :name, 'MIT'
      end
    end
    # tag do
    #   key :name, $th.keys.first
    #   key :description, 'All Tests'
    #   externalDocs do
    #     key :description, 'Find more info here'
    #     key :url, 'https://fairdata.services/Champion/about'
    #   end
    # end
    key :schemes, ["http"]
    key :host, 'localhost:4567'
    key :basePath, '/fsp-harvester-server'
#    key :consumes, ['application/json']
#    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [ ErrorModel, LinksResponse, JSONResponse, LinkedDataResponse, self].freeze

  set_routes(classes: SWAGGERED_CLASSES)

  run! # if app_file == $PROGRAM_NAME

end
