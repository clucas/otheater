docker-compose build
docker-compose up -d
docker-compose run web rake db:create
docker-compose run web rake db:migrate
docker-compose down
docker-compose up -d