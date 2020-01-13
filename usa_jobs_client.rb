require 'jwt'
require 'faraday'
require 'json'

token = 'put the access token from the oauth flow here'

vets_api_url = 'http://localhost:3000/services/veteran_verification/v0/disability_rating'

rsa_public = OpenSSL::PKey::RSA.new(File.read('./mykey.pub'))

response = Faraday.get(vets_api_url, nil, { 
  'Accept' => 'application/jwt',
  'Authorization': "Bearer #{token}"
})

if response.status == 200
  payload = response.body

  begin
    claims = JWT.decode(payload, rsa_public, true, { algorithm: 'RS256' })
    puts 'succesfully validated payload:'
    puts JSON.pretty_generate(claims)
  rescue JWT::VerificationError => e
    puts "rejected token: #{e}"
  end
else
  puts "response status: #{response.status}"
  body = JSON.parse(response.body)
  puts JSON.pretty_generate(body)
end
