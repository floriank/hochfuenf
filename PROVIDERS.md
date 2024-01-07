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
export AUTH0_CLIENT_SECRET={your auth0 client secret}
```

It's advised to add these to your [`.env`](../.env.example) during development.

## Okta

For Okta, testing accoutns is difficult unless you already have an account somewhere
- usually in the form of using it with your company or similar.

### Environment variables

```shell
export OKTA_DOMAIN={your okta domain}
export OKTA_CLIENT_ID={your okta client id}
export OKTA_CLIENT_SECRET={your okta client secret}
```
