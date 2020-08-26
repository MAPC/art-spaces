require 'faraday'

def get_spaces(offset=nil)
  params = { pageSize: 100,
             view: 'Full',
             fields:  ['Space ID', 'Site ID [Link to Sites]', 'Space Name (To Edit)', 'Space Description (To Edit)']}
  params[:offset] = offset if offset

  response = Faraday.get('https://api.airtable.com/v0/appguBbdw1fVlzl9z/Spaces',
                         params,
                         { Authorization: "Bearer #{ENV['AIRTABLE_API_KEY']}" })

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
             fields:  ['Site ID','Site Name (To Edit)','Associated Address(es)']}
  params[:offset] = offset if offset

  response = Faraday.get('https://api.airtable.com/v0/appguBbdw1fVlzl9z/Sites',
                         params,
                         { Authorization: "Bearer #{ENV['AIRTABLE_API_KEY']}" })

  JSON.parse(response.body)['records'].each do |record|
    Site.create(airtable_id: record['id'],
                site_id: record['fields']['Site ID'],
                site_name: record['fields']['Site Name (To Edit)'],
                address: record['fields']['Associated Address(es)'][0],
                location: geocode(record['fields']['Associated Address(es)'][0]))
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

get_spaces
get_sites
