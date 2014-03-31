class API < Grape::API
  prefix 'api'
  mount Acme::GameAPI
end
