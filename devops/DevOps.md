# DevOps

- 1. Get started with Azure DevOps: https://learn.microsoft.com/en-us/training/paths/evolve-your-devops-practices/
- 2. Build applications with Azure DevOps: https://learn.microsoft.com/en-us/training/paths/build-applications-with-azure-devops/

- Code quality: automated testing
    + Run quality tests in build pipeline: https://learn.microsoft.com/en-us/training/modules/run-quality-tests-build-pipeline/
    + Run functional tests in Azure pipeline: https://learn.microsoft.com/en-us/training/modules/run-functional-tests-azure-pipelines

## Pipeline

1. Create multi stage pipeline
    - release approvals: combine approvals, conditions, and triggers

    - environment: Azure App Service instance
        + Library: Variable groups: Release --> mapping to Azure resources name
            - WebAppNameDev: tailspin-space-game-web-dev-001
            - WebAppNameStaging: tailspin-space-game-web-staging-001

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

        az webapp create --name tailspin-space-game-web-dev-001 --resource-group rg-tailspin-space-game --plan asp-tailspin-space-game --runtime "DOTNETCORE:6.0"
            az webapp list-runtimes
        az webapp create --name tailspin-space-game-web-test-001 --resource-group rg-tailspin-space-game --plan asp-tailspin-space-game --runtime "DOTNETCORE:6.0"
        az webapp create --name tailspin-space-game-web-staging-001 --resource-group rg-tailspin-space-game --plan asp-tailspin-space-game --runtime "DOTNETCORE:6.0"

        az webapp list --resource-group rg-tailspin-space-game --query "[].{hostName: defaultHostName, state: state}" --output table
        ```

    3. Clean up
        ```
        az group delete --name rg-tailspin-space-game
        az group list --output table
        ```

3. Git
    ```
    git add azure-pipelines.yml
    git commit -m "Deploy to Staging"
    git push origin release
    ```

## Testing
1. Automated test
2. Test pyramid: 
    - (1) UI --> ... --> (2) Unit