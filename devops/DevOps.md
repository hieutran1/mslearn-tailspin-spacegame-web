# DevOps

## Pipeline

1. Create multi stage pipeline
    - release approvals: combine approvals, conditions, and triggers

    - environment: Azure App Service instance
    - trigger: scheduled trigger, CI trigger, PR trigger, a build completion trigger.
    - release approval: pause the pipeline

    1. Condition
        - pipe (|): spans multiple lines
        - trigger, stages, steps, 
        - variables, environments
        - task, script, template

    2. Stage: 
        - Staging: stress test
        - Dev, Staging, Test stages

2. Create the Azure App Service environments
    1. Select an Azure region: `az account list-locations --query "[].{Name: name, DisplayName: displayName}" --output table`
    2. Create the App Service instances: Dev, Test, and Staging
        - Azure App Service plan defines the CPU, memory, and storage resources for the Web App.
            + B1 Basic plan: for Dev, Test
            + Standard and Premium plans: for production workloads

        ```
        az group create --name rg-tailspin-space-game
        az appservice plan create --name asp-tailspin-space-game --resource-group rg-tailspin-space-game --sku B1 --is-linux

        az webapp create --name tailspin-space-game-web-dev-001 --resource-group rg-tailspin-space-game --plan asp-tailspin-space-game --runtime "DOTNET|6.0"
        az webapp create --name tailspin-space-game-web-test-001 --resource-group rg-tailspin-space-game --plan asp-tailspin-space-game --runtime "DOTNET|6.0"
        az webapp create --name tailspin-space-game-web-staging-001 --resource-group rg-tailspin-space-game --plan asp-tailspin-space-game --runtime "DOTNET|6.0"

        az webapp list --resource-group rg-tailspin-space-game --query "[].{hostName: defaultHostName, state: state}" --output table
        ```
