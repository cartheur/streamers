FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy the *.csproj files.
COPY ./SnakeChaser .

# Copy and publish the application and its libraries.
COPY . .
RUN dotnet restore ./SnakeChaser/ShakeChaser.csproj
RUN dotnet publish ./SnakeChaser/SnakeChaser.csproj -c debug -o /app --no-restore

# Final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .

ENV DOTNET_AttachStdout=1
ENV DOTNET DOTNET_CLI_TELEMETRY_OPTOUT=1
ENTRYPOINT ["dotnet", "ShakeChaser.dll"]
CMD ["-u"]