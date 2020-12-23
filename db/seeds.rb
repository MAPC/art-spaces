require 'faraday'

def get_spaces(offset=nil)
  params = { pageSize: 100,
             view: 'Full',
             fields:  ['Space ID', 'Site ID [Link to Sites]', 'Space Name (To Edit)', 'Space Description (To Edit)']}
  params[:offset] = offset if offset

  response = Faraday.get('https://api.airtable.com/v0/appAb0MHxB8znuYpt/Table%201',
                         params,
                         { Authorization: "Bearer #{Rails.application.credentials.airtable_api_key}" })

  JSON.parse(response.body)['records'].each do |record|
    Space.create(airtable_id: record['id'],
                 space_id: record['fields']['Space ID'],
                 site_id: record['fields']['Site ID [Link to Sites]'][0],
                 space_name: record['fields']['Space Name (To Edit)'],
                 space_description: record['fields']['Space Description (To Edit)'])
  end

  if JSON.parse(response.body)['offset']
    print '.'
    get_spaces(JSON.parse(response.body)['offset'])
  else
    puts 'Done!'
    return true
  end
end

def get_sites(offset=nil)
  params = { pageSize: 100,
             view: 'Grid view',
             fields:  ['Site ID','Site Name','Associated Address(es)', 'Site Description', 'Count of Spaces', 'Vision DB Link', 'Zillow / Loopnet Link', 'Organization Link']}
  params[:offset] = offset if offset

  response = Faraday.get('https://api.airtable.com/v0/appAb0MHxB8znuYpt/Table%201',
                         params,
                         { Authorization: "Bearer #{Rails.application.credentials.airtable_api_key}" })

  JSON.parse(response.body)['records'].each do |record|
    Site.create(airtable_id: record['id'],
                site_id: record['fields']['Site ID'],
                site_name: record['fields']['Site Name'],
                address: record['fields']['Associated Address(es)'],
                description: record['fields']['Site Description'],
                count_of_spaces: record['fields']['Count of Spaces'],
                vision_db_link: record['fields']['Vision DB Link'],
                zillow_link: record['fields']['Zillow / Loopnet Link'],
                organization_link: record['fields']['Organization Link'],
                location: geocode(record['fields']['Associated Address(es)']))
  end

  if JSON.parse(response.body)['offset']
    print '.'
    get_sites(JSON.parse(response.body)['offset'])
  else
    puts 'Done!'
    return true
  end
end

def geocode(address)
  sleep(0.5)
  response = Faraday.get('https://pelias.mapc.org/v1/search',
                         {
                           text: address,
                           'boundary.gid': 'whosonfirst:region:85688645',
                           size: 1
                         })
  return nil if JSON.parse(response.body)['features'].size === 0
  return 'POINT(' +
         JSON.parse(response.body)['features'][0]['geometry']['coordinates'][0].to_s +
         ' ' +
         JSON.parse(response.body)['features'][0]['geometry']['coordinates'][1].to_s +
         ')'
end

# get_spaces
get_sites
