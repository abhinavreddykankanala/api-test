# Use the official .NET SDK as a base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Restore dependencies
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o out

# Create the final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the published application from the build image
COPY --from=build /app/out .

# Expose the port the application will run on
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "YourAppName.dll"]
