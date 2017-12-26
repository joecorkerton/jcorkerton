# jcorkerton

## Prerequesites

* [Elixir]
* [Phoenix]
* [PostgreSQL]
* [Gigalixir]

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

To run the application on localhost:4000:

```sh
$ mix phx.server
```

## Deploymemt

To deploy the application to gigalixir:

```sh
$ git push gigalixir master
```

[elixir]: https://elixir-lang.org/install.html
[phoenix]: https://hexdocs.pm/phoenix/installation.html#content
[postgresql]: http://www.postgresql.org
[gigalixir]: http://gigalixir.readthedocs.io/en/latest/main.html
