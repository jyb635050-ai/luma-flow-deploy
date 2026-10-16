FROM node:24-bookworm-slim AS node
FROM golang:1.26-bookworm AS build
WORKDIR /src
RUN git init . && git remote add origin https://github.com/TNTcraftHIM/Piik.git && git fetch --depth=1 origin 390e637d4e9090e6258ccc3d3a0a3f877d81b25c && git checkout --detach FETCH_HEAD
COPY web/ ./internal/server/webassets/dist/
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w" -o /out/luma-server ./cmd/piik-server
RUN node --input-type=module -e 'import { writeServerLicenseNotices } from "./scripts/package-licenses.mjs"; writeServerLicenseNotices(process.cwd(), "/out/THIRD-PARTY-NOTICES.txt", "go", {goos:"linux",goarch:"amd64"});'

FROM alpine:3.23
RUN apk add --no-cache ca-certificates && adduser -D -u 10001 luma
WORKDIR /app
COPY --from=build /out/luma-server /out/THIRD-PARTY-NOTICES.txt /src/LICENSE ./
COPY start.sh ./start.sh
USER 10001:10001
EXPOSE 10000
ENTRYPOINT ["/bin/sh", "/app/start.sh"]
