FROM dart:stable AS build
# We need the whole repo because server depends on the app package via a path.
WORKDIR /app
COPY . .

WORKDIR /app/server
RUN dart pub get
# Copy prebuilt Flutter web assets (place your build output into server/web_build before building)
COPY server/web_build /app/server/web_build
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart compile exe bin/server.dart -o /app/server/bin/server

FROM dart:stable AS runtime
WORKDIR /app
COPY --from=build /app/server/bin/server /app/bin/server

ENV PORT=8080
EXPOSE 8080

CMD ["/app/bin/server"]
