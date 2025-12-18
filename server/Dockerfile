FROM dart:stable AS build
# We need the whole repo because server depends on the app package via a path.
WORKDIR /app
COPY . .

WORKDIR /app/server
RUN dart pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart compile exe server/bin/server.dart -o /app/server/bin/server

FROM dart:stable AS runtime
WORKDIR /app
COPY --from=build /app/server/bin/server /app/bin/server

ENV PORT=8080
EXPOSE 8080

CMD ["/app/bin/server"]
