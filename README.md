# Custom Swagger API using Docker on App Service

*Related posts*
* [Serverless like a Superhero with Azure Functions](https://tattoocoder.com/serverless-like-a-superhero-with-azure-functions/)
* [Unmasking your swagger with proxies in Azure Functions](https://tattoocoder.com/unmasking-your-swagger-with-proxies-in-azure-functions/)
* [Use a container to show your function swagger](https://tattoocoder.com/use-a-container-to-show-your-function-swagger/)

## Using Docker for what Docker was meant for...

One option for enabling the Swagger-UI capabilities is to direct the consumers of the api to http://petstore.swagger.io and have them put the url in the box at the top of the page. That's professional right? :-/ Alternatively, you can add the url of the service to the end with `?url=` such as `http://petstore.swagger.io?url=https://yoursite.azurewebsites.net/docs/swagger.json`, but again probably not the best option.

Here we can take advantage of Docker here and use the swaggerapi/swagger-ui Docker image and set some ENV variables within an Azure AppService Web Application and accomplish our own SwaggerUI.

## Creating a new AppService (Linux)

Here we will use the Azure CLI to create our App Service instance for the Docker run Swagger UI.

```bash
#Login to Azure
az login

# Create a Resource Group
az group create --name myswaggergroup --location 'West US'

# Create an App Service Plan
az appservice plan create --name myswaggerplan --resource-group myswaggergroup --location 'West US' --is-linux --sku S1

# Create a Web App
az appservice web create --name swaggeruiApp --plan myswaggerplan --resource-group myswaggergroup
```

## Setting the Docker Image and ENV Variables

The following command sets the environment variable for the Docker image to point the UI to the swagger definition for our application instead of the default PetStore API.

```bash
az appservice web config appsettings update -g myswaggergroup -n swaggeruiApp --settings API_URL="http://myappname.azurewebsites.net/docs/swagger.json"
```

## Set the Docker Image

```bash
# Configure Web App with a Custom Docker Container from Docker Hub
az appservice web config container update --docker-custom-image-name 'swaggerapi/swagger-ui' --name 'swaggeruiApp' --resource-group 'swaggeruiApp'
```

*You will need to take the url of the new web application and add it to the allowable addresses in the CORS settings for your Azure Functions.*


---

> [tattoocoder.com](https://tattoocoder.com) &nbsp;&middot;&nbsp;
> GitHub [@spboyer](https://github.com/spboyer) &nbsp;&middot;&nbsp;
> Twitter [@spboyer](https://twitter.com/spboyer)