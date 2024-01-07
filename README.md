# Hochfuenf

This is a small application that aims to provide a FOSS alternative to tools
like [15Five](https://15five.com). It's also a way for me to learn and reason
around authentication with common IDPs (such as [Okta](https://okta.com), 
[OneLogin](https://onelogin.com), etc.) in an Elixir context.

Ultimately, this should be provide an easy way for groups of people to tell 
each other that they did good work an are appreciated, in a manner that is 
transparent and traceable.

## Getting started with development

This project is a [Phoenix Project, using Elixir](https://phoenixframework.org).
You can run it locally with a PostgreSQL database or you can run it with the
dev setup included.

Regardless of which option you choose, you probably want to run

```shell
# if you use direnv
$ cp .envrc.example .envrc
# if you use dotenv
$ cp .env.example .env
```

### Docker setup [recommended]

#### Requirements

- `docker`
- `docker compose`

Run `make` and follow the instructions. For a quick setup, run `make setup`, followed
by make start.

### Locally

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

#### Learn more about Phoenix and Elixir

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
