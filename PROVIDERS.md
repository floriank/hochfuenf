# Authentication Providers

In genreal, Hochfuenf tries not to store passwords or provide its own authentication,
therefore it's only usable with common authentication providers.

## Auth0

You can register and create a test account with Auth0 relatively easy, 
[click here](https://auth0.com/signup) to get started.

### Environment variables

```shell
export AUTH0_DOMAIN={your auth0 domain}
export AUTH0_CLIENT_ID={your auth0 client id}
export AUTH0_CLIENT_SECRET={yout auth0 client secret}
```

It's advised to add these to your [`.env`](../.env.example) during development.
