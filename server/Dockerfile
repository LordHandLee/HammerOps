FROM dart:stable AS build
WORKDIR /app

# Resolve dependencies first (cache-friendly)
COPY pubspec.* ./
RUN dart pub get

# Copy source and generate drift code
COPY . .
RUN dart run build_runner build --delete-conflicting-outputs

# Compile to native executable for smaller runtime
RUN dart compile exe bin/server.dart -o /app/bin/server

FROM dart:stable AS runtime
WORKDIR /app

# Copy compiled binary and any assets needed at runtime
COPY --from=build /app/bin/server /app/bin/server

ENV PORT=8080
EXPOSE 8080

CMD ["/app/bin/server"]
