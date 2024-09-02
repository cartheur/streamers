FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy the *.csproj files.
COPY ./SnakeChaser .

# Copy and publish the application and its libraries.
COPY . .
RUN dotnet restore ./SnakeChaser/*.csproj
RUN dotnet publish ./SnakeChaser/*.csproj -c debug -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "SnakeChaser.dll"]