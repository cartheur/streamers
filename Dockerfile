FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# copy everything else and build app
COPY SnakeChaser/*.csproj .
RUN dotnet restore
COPY SnakeChaser/. .
RUN dotnet publish -c release -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
EXPOSE 8080
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["./SnakeChaser"]