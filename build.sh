# Build the graphite container image
REL=${1:-v1.0}
cat ~/.ghcr-token | docker login ghcr.io -u gdha --password-stdin
echo "Building graphite:$REL"
docker build . --tag ghcr.io/gdha/graphite:$REL
# docker tag graphite graphite:$REL
echo "Pushing graphite:$REL to GitHub Docker Container registry"
docker push ghcr.io/gdha/graphite:$REL
