LOCATION='eastus'                                        
RESOURCE_GROUP_NAME='msdocs-expressjs-mongodb-tutorial'

WEB_APP_NAME='msdocs-expressjs-mongodb-123'
APP_SERVICE_PLAN_NAME='msdocs-expressjs-mongodb-plan-123'    
RUNTIME='NODE|14-lts'

# Create a resource group
az group create --location $LOCATION --name $RESOURCE_GROUP_NAME

# Create an app service plan
az appservice plan create --name $APP_SERVICE_PLAN_NAME --resource-group $RESOURCE_GROUP_NAME --sku B1 --is-linux

# Create the web app in the app service
az webapp create --name $WEB_APP_NAME --runtime $RUNTIME --plan $APP_SERVICE_PLAN_NAME --resource-group $RESOURCE_GROUP_NAME