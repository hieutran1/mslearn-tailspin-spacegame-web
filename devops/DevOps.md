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

```
git fetch upstream failed-test
git checkout -B failed-test upstream/failed-test
```

```
dotnet tool restore
```

```
dotnet new tool-manifest
dotnet tool install dotnet-reportgenerator-globaltool

dotnet add Tailspin.SpaceGame.Web.Tests package coverlet.msbuild
```

```
git add Tailspin.SpaceGame.Web.Tests/Tailspin.SpaceGame.Web.Tests.csproj
git add .config/dotnet-tools.json
git commit -m "Configure code coverage tests"
```

```
git push origin failed-test
```

```
dotnet test --no-build `
  --configuration Release `
  /p:CollectCoverage=true `
  /p:CoverletOutputFormat=cobertura `
  /p:CoverletOutput=./TestResults/Coverage/

dotnet tool run reportgenerator `
  -- "-reports:./Tailspin.SpaceGame.Web.Tests/TestResults/Coverage/coverage.cobertura.xml" `
  "-targetdir:./CodeCoverage" `
  "-reporttypes:HtmlInline_AzurePipelines"

```

- Remove code coverage: `rm -rf CodeCoverage/`

- Extensions for Azure DevOps: https://marketplace.visualstudio.com/
    + Code Coverage Widgets by Shane Davis

## Manage build dependencies
- https://learn.microsoft.com/en-us/training/modules/manage-build-dependencies

1. How can I identify dependencies?
    - Duplicate code.
    - High cohesion and low coupling
        + High cohesion: code in a single place.
        + low coupling: separating unrelated parts of code base.
    - Individual lifecycle
    - Stable parts
    - Independent code and components
2. What kinds of packages are there?
    - NuGet: packages .NET libraries. Zip format and **.nupkg** extension
    - NPM: packages JavaScript libraries
    - Maven: packages Java libraries
    - Docker: packages software in isolated units called `containers`
3. Where are packages hosted?
    - NuGet Gallery: https://www.nuget.org/
    - NPM: https://www.npmjs.com/
    - Maven Central Repository: https://mvnrepository.com/
    - Docker Hub: https://hub.docker.com/

    - **package feed**: package repository server. 
        + Azure Artifacts and MyGet or file share: https://learn.microsoft.com/en-us/nuget/hosting-packages/overview
4. What elements make up a good dependency management strategy?
    - Standardization
    - Packaging formats and sources
    - Versioning
5. How are packages versioned?
    - Semantic Versioning: https://semver.org/
        + format: __Major.Minor.Patch[-Suffix]__
            - __Major__: breaking changes
            - __Minor__: new features
            - __Patch__: bug fixes
            - __-Suffix__: pre-release version. Ex: 1.0.0-beta1

    - `Install-Package Newtonsoft.Json -Version 13.0.1`
    - version: `[1.0,2.0)` --> greater than or equal to 1.0, and less than 2.0
    - `.csproj`:
        ```
        <ItemGroup>
            <PackageReference Include="Newtonsoft.Json" Version="13.0.1" />
        </ItemGroup>
        ```

6. What is Azure Artifacts? 
    - to host their .NET package

7. Include a versioning strategy in your build pipeline
    - Feeds has three view:
        + Release: @release view, official releases.
        + Prerelease:  @prerelease view, has '-Suffix'
        + Local: @local view, has release and prerelease packages and upstream sources
8. Package security in Azure Artifacts
    - Feed permissions: Owners, Contributors, Collaborators, and Readers.
    - Configure the pipeline to access security and license ratings
        + tool: Build process -> scans packages and give feedback. CD process -> performance scans.
        + use tools:  Mend Bolt and Black Duck
            - Mend Bolt: https://www.mend.io/free-developer-tools/bolt/
            - Black Duck: https://www.synopsys.com/software-integrity/security-testing/software-composition-analysis.html

9. Set up Azure Artifacts
    1. Go to `Artifacts` tab, create feed name: `Tailspin.SpaceGame.Web.Models`
    2. Create a pipeline for your package: Set permissions
        - Users/Groups: `Space Game - web - Dependencies Build Service`, __Contributor__ role.