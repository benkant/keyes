require 'httparty'
require 'json'

request_body = {
  ip_address: '5.10.77.233',
  city: 'Perth',
  region: 'WA',
  postal: '6008',
  country: 'ng'
}

headers = {
  'Content-Type' => 'application/json'
}

response = HTTParty.post('http://localhost:4567/checks',
                         body: request_body,
                         options: {headers: headers})

puts response.inspect

