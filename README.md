# Threddr

### Setup

1. Install elixir dependencies: `mix deps.get`
2. Install npm dependencies: `npm install --prefix assets`
3. Create a [Twitter app](https://developer.twitter.com/apps)
4. Create the `.env` file (`cp .env.template .env`) and add the Twitter credentials
5. Generate a token (`mix phx.gen.secret`) and add it as the `APP_SECRET` in the `.env` file

### Running locally

1. Ensure env variables are sourced: `source .env`
1. Start the server: `mix phx.server`

You can now visit [`localhost:4000`](http://localhost:4000) from a browser.
