FROM python:3.7.13-bullseye
RUN mkdir -p /var/cairo
WORKDIR /var/cairo
COPY ./ /var/cairo/
ENTRYPOINT tail -f /dev/null