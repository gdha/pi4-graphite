# Build the graphite container image
#
# To find the current used version number use command:
# $ kubectl describe pod -n graphite  graphite-0 | grep -i image:
#   Image:          ghcr.io/gdha/graphite:v1.2
# To build a newer version use: ./build.sh v1.3  (example)
REL=${1:-v1.0}
cat ~/.ghcr-token | docker login ghcr.io -u gdha --password-stdin
echo "Building graphite:$REL"
docker build . --tag ghcr.io/gdha/graphite:$REL
# docker tag graphite graphite:$REL
echo "Pushing graphite:$REL to GitHub Docker Container registry"
docker push ghcr.io/gdha/graphite:$REL
