
def set_routes(classes: allclasses) # $th is the test configuration hash
  
  get '/fsp-harvester-server' do
    content_type :json
    response.body = JSON.dump(Swagger::Blocks.build_root_json(classes))
    #Swagger::Blocks.build_root_json(classes)
  end

  get '/fsp-harvester-server/links' do
    guid = params['guid']
    @links, @metadata = HarvesterTools::Utils.resolve_guid(guid: guid)
    @html = @links.map{|l| l.to_html}
    @html = @html.join("\n")
    @id = guid
    erb :html_links_layout
  end

  get '/fsp-harvester-server/ld' do
    content_type "application/ld+json"
    guid = params['guid']
    @links, @metadata = HarvesterTools::Utils.resolve_guid(guid: guid)
    @metadata = FspHarvester::Utils.gather_metadata_from_describedby_links(links: @links, metadata: @metadata)
    graph = @metadata.graph
    graph.dump(:jsonld)
  end

  get '/fsp-harvester-server/json' do
    content_type :json
    guid = params['guid']
    @links, @metadata = HarvesterTools::Utils.resolve_guid(guid: guid)
    response = @metadata.hash.to_json || '{}'
    response

  end

  get '/fsp-harvester-server/ld-by-old-workflow' do
    content_type :json
    guid = params['guid']
    @links, @metadata = HarvesterTools::Utils.resolve_guid(guid: guid)
    meta = HarvesterTools::BruteForce.begin_brute_force(guid: guid, metadata: @metadata)
    graph = meta.graph
    graph.dump(:jsonld)
  end

end

