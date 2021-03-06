# jcorkerton

[![Build Status](https://travis-ci.org/joecorkerton/jcorkerton.svg?branch=master)](https://travis-ci.org/joecorkerton/jcorkerton)

## Prerequesites

* [Elixir]
* [Phoenix]
* [PostgreSQL]
* [Gigalixir]
* Npm
* Python 2.7 (Node gyp doesn't support Python 3..)
* Chromedriver

## Installation

Clone the repository:

```sh
$ git clone git@github.com:joecorkerton/jcorkerton.git
```

Install dependencies:

```sh
$ mix deps.get
$ mix ecto.create
```

## Usage

To run the application on localhost:4000

```sh
$ mix phx.server
```

To run the application in terminal

```sh
$ iex -S mix phx.server
```

## Testing

Launch chromedriver:

```sh
$ chromedriver
```

Run all tests:

```sh
$ mix test
```

Format files:
```sh
$ mix format
```

Credo style suggestions:
```sh
$ mix credo
```

## Deploymemt

Deployment is managed by [travis-ci], when tests pass on master

[elixir]: https://elixir-lang.org/install.html
[phoenix]: https://hexdocs.pm/phoenix/installation.html#content
[postgresql]: http://www.postgresql.org
[gigalixir]: http://gigalixir.readthedocs.io/en/latest/main.html
[travis-ci]: https://travis-ci.org/
