FROM scratch

# https://github.com/kubernetes/kubernetes/tree/release-1.4/examples/https-nginx
# go get -v
# CGO_ENABLED=0 GOOS=linux go build -v -ldflags "-s" -a -installsuffix cgo make_secret.go
# verify make_secret is static: ldd make_secret
# strip/-O2?
# put make_secret in usr/bin
# tar czvf rootfs.tar.gz usr
#
# some ideas on how to auto-build:
# https://medium.com/@kelseyhightower/optimizing-docker-images-for-static-binaries-b5696e26eb07#.ihym3z5wm
# https://developer.atlassian.com/blog/2015/07/osx-static-golang-binaries-with-docker/

ADD rootfs.tar.gz /
CMD ["/usr/bin/make_secret"]
