# GoReleaser builds the binary outside the image, so this is just packaging.
FROM scratch
COPY idp /usr/local/bin/idp
ENTRYPOINT ["/usr/local/bin/idp"]