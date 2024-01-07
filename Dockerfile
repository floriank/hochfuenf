FROM elixir:1.16.0-slim as base

LABEL service="Hochfuenf"

LABEL org.opencontainers.image.title="Hochfuenf (development image)"
LABEL org.opencontainers.image.url="https://github.com/floriank/hochfuenf"
LABEL org.opencontainers.image.source="https://github.com/floriank/hochfuenf"

COPY .build-deps /
RUN apt-get update
RUN cat .build-deps | xargs apt-get install -y && rm -rf /var/lib/apt/lists/*

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN mkdir /app

# RUN addgroup -gid $GROUP_ID devgroup && adduser -uid $USER_ID -gid $GROUP_ID devuser 
RUN adduser \
    --disabled-password \
    --gecos "" \
    --no-create-home \
    --home "/app" \
    --shell "/sbin/nologin" \
    --uid $USER_ID \
    devuser
RUN chown -R devuser:devuser /app

USER devuser

WORKDIR /app

COPY mix* ./
RUN mix do \
    local.hex --force, \
    local.rebar --force

RUN mix deps.get

# Development image
FROM base as dev
ENV ERL_AFLAGS="-kernel shell_history enabled"
ENV MIX_ENV=dev
COPY . ./

# Release image
FROM base as release

LABEL org.opencontainers.image.title="Hochfuenf (production image)"
LABEL org.opencontainers.image.url="https://github.com/floriank/hochfuenf"
LABEL org.opencontainers.image.source="https://github.com/floriank/hochfuenf"

# we release in  production mode, see config/prod.exs for details
ENV MIX_ENV=prod
COPY lib lib
COPY config config
COPY README.md README.md
RUN mix do compile, release

# bind to 0.0.0.0
ENV HOCH_IP 0.0.0.0

# internally bound port
ENV HOCH_PORT 8080

# copy over the built release
RUN cp -r /app/_build/prod/rel/hochfuenf/* /app
RUN find /app -executable -type f -exec chmod +x {} +

# create the entry folder for specifications on startup
RUN mkdir /specifications

CMD [ "/app/bin/hochfuenf", "start" ]
