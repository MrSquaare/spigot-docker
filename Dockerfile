FROM mrsquaare/minecraft-docker

ARG IMAGE_CREATION
ARG IMAGE_VERSION

LABEL fr.mrsquaare.image.created=${IMAGE_CREATION}
LABEL fr.mrsquaare.image.authors="MrSquaare <contact@mrsquaare.fr> (@MrSquaare)"
LABEL fr.mrsquaare.image.url="https://hub.docker.com/r/mrsquaare/spigot-docker"
LABEL fr.mrsquaare.image.source="https://github.com/MrSquaare/spigot-docker"
LABEL fr.mrsquaare.image.version=${IMAGE_VERSION}
LABEL fr.mrsquaare.image.vendor="MrSquaare"
LABEL fr.mrsquaare.image.licenses="MIT"
LABEL fr.mrsquaare.image.title="Spigot Docker"
LABEL fr.mrsquaare.image.description="Docker image for Spigot"

COPY docker-entrypoint.sh /usr/local/bin
COPY scripts/ /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
