# Sxmp-api-todolist-aws

## Description

This is an automatic boilerplate for a new NestJS application.
Please edit this docs ...

## Git clone and initial setup

```sh
# clone this repo
$ git clone https://github.com/xgeekshq/sxmp-api-todolist-aws.git

# cd into it
$ cd sxmp-api-todolist-aws

# create .env file
echo "NODE_ENV=example" >> .env

# run 
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Test

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Test with curl

```sh
# GET /todos
curl -sf -X GET \
  -H "Accept: application/json" \
  https://sxmp-api-todolist-aws-dev.xgeeks.tech/todos/

# POST /todos
curl -sf -X POST \
  -d '{"name":"my-first-todo","description":"buy milk"}' \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  https://sxmp-api-todolist-aws-dev.xgeeks.tech/todos/
```


## Links

- Dev Team: idp_training
- Team Lead: TODO
- Website: https://sxmp-api-todolist-aws-dev.aws.xgeeks.tech
