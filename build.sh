#!/bin/bash


if [ -z ${TRAVIS_BUILD_DIR} ]; then
    echo "Assuming local build, configure generic vars"
    IMAGE='vps-ubuntu'
    DOCKER_NAMESPACE='inetsix'
    TRAVIS_BUILD_DIR=${PWD}
fi

echo " * Namespace: "${DOCKER_NAMESPACE}
echo " * Image: "${IMAGE}

IMAGE_NAME=${DOCKER_NAMESPACE}"/"${IMAGE}
echo "Building images for ${IMAGE_NAME}"

while IFS="" read -r UBUNTU_VERSION || [ -n "$UBUNTU_VERSION" ]
do
    echo " > Build docker image for version ${UBUNTU_VERSION}"
    docker build \
        --no-cache \
        --pull \
        --quiet \
        --build-arg UBUNTU_VERSION="${UBUNTU_VERSION}" \
        --tag "${IMAGE_NAME}:${UBUNTU_VERSION}" \
        --file "${TRAVIS_BUILD_DIR}/Dockerfile" \
        "${TRAVIS_BUILD_DIR}"
done < TAGS.txt

echo "Login to docker HUB"
# docker login --username="${DOCKER_USER}" --password="${DOCKER_PASSWORD}"
echo "Docker password is: ${DOCKER_PASSWORD}"
echo ${DOCKER_PASSWORD} | docker login --username="${DOCKER_USER}" --password-stdin
echo "Push images to registry"
while IFS="" read -r UBUNTU_VERSION || [ -n "$UBUNTU_VERSION" ]
do
    echo " > Pushing tag ${UBUNTU_VERSION}"
    docker push "${IMAGE_NAME}:${UBUNTU_VERSION}"
done < TAGS.txt

