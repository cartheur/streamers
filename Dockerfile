FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy the *.csproj files.
COPY ./SnakeChaser .

# Copy and publish the application and its libraries.
COPY . .
RUN dotnet restore ./SnakeChaser/*.csproj
RUN dotnet publish ./SnakeChaser/*.csproj -c debug -o /app --no-restore

# Final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
EXPOSE 8080
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
ENTRYPOINT ["./SnakeChaser"]