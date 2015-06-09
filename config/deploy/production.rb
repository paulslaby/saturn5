set :stage,     :production
set :rails_env, 'production'
set :deploy_to, '/var/www/saturn5_com'

server 'REPLACE_ME',
       user: 'saturn5',
       roles: %w(web app db)
