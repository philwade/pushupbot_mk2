 docker build --tag=build-pushupbot -f docker/Dockerfile .
 docker run --env-file .env --volume $PWD/_build:/app/_build build-pushupbot mix release --env=prod
