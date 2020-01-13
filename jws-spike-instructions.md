# JWS for USA Jobs Discovery

### Generating a key
Generate an RSA key pair. Don't add a password to this:
```
openssl genrsa -out mykey.pem 1024
```

Pull public key out of the generated private key file. I only want
this to simulate what it would be like if a consumer had only the
public key available to them instead of the combined key in the 
mykey.pem file:
```
openssl rsa -in mykey.pem -pubout > mykey.pub
```

### App changes
I made a few notable changes to get this working:
- Registered a new mime type in `config/initializers/mime_types.rb` for `application/jwt`
- Added a `respond_to` switch in `disability_rating_controller.rb` to give back the token when `application/jwt` is the `Accept` header.
- Removed the `format: 'json'` option from the Veteran Verification routes file. This was sneakily forcing the `request.format` to be `:json`, regardless of what was in the `Accept` header.
- Created a `Notary` service to sign the token. In the actual implementation, I don't love having to read the token file every time a request comes in. We'll likely want to read that into a constant on server startup instead.
- Added a filepath to the private RSA key in `config/settings.yml`

### Storing a key
For securely storing the key that we generate for deployed environments, we can use the example of the Salesforce key:
- [Path the key is stored at](https://github.com/department-of-veterans-affairs/devops/blob/386ebb56892a3cd5e5e5aad7143014455db899cd/ansible/deployment/config/vets-api/prod-settings.local.yml.j2#L289)
- [Storing the key](https://github.com/department-of-veterans-affairs/devops/blob/b8a605395da7ec288eec5a93da5271ac3fbc2c04/ansible/deployment/config/vets-api-worker-vagov-prod.yml#L90)
- [Using the key](https://github.com/department-of-veterans-affairs/vets-api/blob/287ccf23f1580aa7d0ebf1076f1aae9c16136dc2/lib/salesforce/service.rb#L30)

### Try it yourself
1. Generate a key pair using the instructions above. 
2. Move `mykey.pem` into `config/certs`
3. Start the Rails server
4. Get an access token for a user by going through the OAuth flow
5. Put your access token into the `token` variable on line 5 of `usa_jobs_client.rb` and save.
6. Run `ruby usa_jobs_client.rb`, which will make a request to the Rails server and then use the public key you left at the root of the project to verify the signed token.

