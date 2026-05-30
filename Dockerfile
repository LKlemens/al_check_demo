FROM ghcr.io/livebook-dev/livebook:latest

# Bake the demo notebook and its asciinema casts into /apps. Livebook
# auto-loads every notebook under LIVEBOOK_APPS_PATH as a deployable app
# on startup, so the tour is reachable at /apps/al-check-demo with no
# extra config.
COPY demo.livemd /apps/demo.livemd
COPY casts       /apps/casts

ENV LIVEBOOK_APPS_PATH=/apps
ENV LIVEBOOK_IP=0.0.0.0
ENV LIVEBOOK_PORT=8080

EXPOSE 8080
