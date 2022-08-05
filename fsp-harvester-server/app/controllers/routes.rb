
def set_routes(classes: allclasses) # $th is the test configuration hash
  
  get '/fsp-harvester-server' do
    content_type :json
    response.body = JSON.dump(Swagger::Blocks.build_root_json(classes))
    #Swagger::Blocks.build_root_json(classes)
  end

  get '/fsp-harvester-server/links' do
    guid = params['guid']
    @links, @metadata = FspHarvester::Utils.resolve_guid(guid: guid)
    @html = @links.map{|l| l.to_html}
    @html = @html.join("\n")
    @id = guid
    erb :html_links_layout
  end

  get '/fsp-harvester-server/ld' do
    content_type "text/turtle"
    guid = params['guid']
    @links, @metadata = FspHarvester::Utils.resolve_guid(guid: guid)
    @metadata = FspHarvester::Utils.gather_metadata_from_describedby_links(links: @links, metadata: @metadata)
    graph = @metadata.graph
    $stderr.puts "graph size #{graph.size}"
    $stderr.puts "graph size #{graph.inspect}"

    graph.dump(:turtle)
  end

  get '/fsp-harvester-server/json' do
    content_type :json
    guid = params['guid']
    @links, @metadata = FspHarvester::Utils.resolve_guid(guid: guid)
    response = @metadata.hash.to_json || '{}'
    response

  end

  # $th.each do |guid, val|
  #   get "/#{val['title']}" do
  #     json Swagger::Blocks.build_root_json(classes)
  #   end
  # end

  # helper do
  #   def j(data)
  #     JSON.dump(data)
  #   end
  # end
end

