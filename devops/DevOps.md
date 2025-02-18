# Azure DevOps

- Azure DevOps: learning paths
    - 1. Part 1: Get started with Azure DevOps
        + https://learn.microsoft.com/en-us/training/paths/evolve-your-devops-practices/
    - 2. Part 2: Build applications with Azure DevOps
        + https://learn.microsoft.com/en-us/training/paths/build-applications-with-azure-devops/
    - 3. Part 3: Deploy applications with Azure DevOps: 
        + https://learn.microsoft.com/en-us/training/paths/deploy-applications-with-azure-devops/

    - 1. Create a build pipeline: https://learn.microsoft.com/en-us/training/modules/create-a-build-pipeline/?view=azure-devops
    - 2. Implement a code workflow in your build pipeline by using Git and GitHub: 
        + https://learn.microsoft.com/en-us/training/modules/implement-code-workflow/?view=azure-devops
    - 3. Run quality tests in your build pipeline:
        + https://learn.microsoft.com/en-us/training/modules/run-quality-tests-build-pipeline/?view=azure-devops
    - 4. Manage build dependencies with Azure Artifacts:
        + https://learn.microsoft.com/en-us/training/modules/manage-build-dependencies/?view=azure-devops

- Bicep: learning paths
    1. Part 1: Fundamentals of Bicep: https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/
    2. Part 2: Intermediate Bicep: https://learn.microsoft.com/en-us/training/paths/intermediate-bicep/
    3. Part 3: Advanced Bicep: https://learn.microsoft.com/en-us/training/paths/advanced-bicep/

    4. Adding Bicep code to a deployment pipeline:
        1. Option 1: Deploy Azure resources by using Bicep and Azure Pipelines
            - https://learn.microsoft.com/en-us/training/paths/bicep-azure-pipelines/
        2. Option 2: Deploy Azure resources by using Bicep and GitHub Actions
            - https://learn.microsoft.com/en-us/training/paths/bicep-github-actions/

- Terraform: learning paths
    + https://learn.microsoft.com/en-us/training/paths/terraform-fundamentals/
    
- Code quality: automated testing
    + Run quality tests in build pipeline: https://learn.microsoft.com/en-us/training/modules/run-quality-tests-build-pipeline/
    + Run functional tests in Azure pipeline: https://learn.microsoft.com/en-us/training/modules/run-functional-tests-azure-pipelines

- Azure pipeline:
    + Build: https://learn.microsoft.com/en-us/azure/devops/pipelines/build/ci-build-git?view=azure-devops&tabs=yaml
    + Deploy: https://learn.microsoft.com/en-us/azure/devops/pipelines/overview-azure?view=azure-devops
    + Artifacts: https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/artifacts-overview?view=azure-devops&tabs=nuget%2Cnugetserver

- Run a Template that sets up your Azure DevOps organization: https://azuredevopsdemogenerator.azurewebsites.net/environment/createproject

- Git and GitHub workflow in VSCode:
    + https://code.visualstudio.com/docs/sourcecontrol/github
- Git:
    + Git-SCM: https://git-scm.com/
    + Pro Git: https://git-scm.com/book/en/v2
- NPM

- Azure
    + Azure resources management: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview
    + Azure Pricing Calculator: https://azure.microsoft.com/en-us/pricing/calculator/
    
## Azure Pipeline

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
            + --sku: B1 Basic plan: for Dev, Test. F1: free
            + Standard and Premium plans: for production workloads

        ```
        az group create --name rg-tailspin-space-game
        az appservice plan create --name asp-tailspin-space-game --resource-group rg-tailspin-space-game --sku F1 --is-linux

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

3. Git & dotnet cli
    
    ```
    origin: fetch & push
        git clone https://github.com/your-name/mslearn-tailspin-spacegame-web.git        
    upstream: fetch & push
        git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git
    git remote -v

    cd ~ --> move to Home folder
    code -r . --> open vscode
    ```

    ```
    Trust local: 
        dotnet dev-certs https --trust

    Run local:
        dotnet build --configuration Release
        dotnet run --configuration Release --no-build --project Tailspin.SpaceGame.Web

    Push local branch:
        git add .
        git commit -m "Deploy to Staging"
        git push origin feature/home-page-text

    Synchronize any changes to the main branch:
        git checkout main
        git pull origin main

        git checkout feature/home-page-text
        git merge main

    ```

## Run quality tests in azure build pipeline by using Azure Pipelines
1. Automated testing?
    - Manual tests vs Automated tests
        + Manual tests: `Usability testing`

    - Functional tests vs Nonfunctional tests
        + Functional tests: verify each function of the software does what it should. Provide input and check that the output is what you expect.
            - Ex: automation test from UI
            - **Kinds of functional tests**:
                + 1. Smoke testing: verifies the most basic functionality of your application or service.
                    - These tests are often run before more complete and exhaustive tests. Smoke tests should run quickly.
                    - Ex: test a website is available. Return 200 (OK) HTTP status, 404 (Not Found), 500 (Internal server Error).

                + 2. Unit testing: verifies the most fundamental components of your program or library, such as an individual function or method.
                    - `UI test` is also a kine of `Unit test`.
                    
                + 3. Integration testing: verifies that multiple software components work together to form a complete system.
                    - Ex: an e-commerce system might include a website, a products database, and a payment system. 
                        + Write an integration test that adds items to the shopping cart and then purchases the items.
                        + verifies that the web application can connect to the products database and then fulfill the order.

                + 4. Regression testing: 
                    - A **regression** occurs when existing behavior either changes or breaks after you add or change a feature.
                    - **Regression testing** helps determine whether code, configuration, or other changes affect the software's overall behavior.
                    - **Regression testing** is important because a change in one component can affect the behavior of another component.
                    - Ex: Optimize a database for `write` performance.
                        + The `read` performance of that database, which is handled by another component, might unexpectedly drop.
                        + The drop in `read` performance is a regression.

                + 5. Sanity testing: 
                    - involves testing each major component of a piece of software to verify that the software appears to be working and can undergo more thorough testing. 
                    - sanity tests is less thorough than `regression tests` or `unit tests`, but `sanity tests` are broader than `smoke tests`.

                + 6. User interface testing (UI testing): verifies the behavior of an application's user interface.
                    - capture-and-replay system to automatically build your UI tests. coded by hand.
                    
                + 7. Usability testing: is a form of **manual testing** that verifies an application's behavior from the user's perspective.
                    - Whereas `UI testing` focuses on whether a feature behaves as expected, `usability testing` helps verify that the software is intuitive and meets the user's needs.
                    - Ex: a website that includes a link to the user's profile.
                        + A `UI test` can verify that the link is present and that it brings up the user's profile when the link is clicked.
                        + However, if humans can't easily locate this link, they might become frustrated when they try to access their profile.

                + 8. User acceptance testing (UAT)
                    - like `usability testing`, focuses on an application's behavior from the user's perspective.
                    - Unlike usability testing, UAT is typically done by real end users.

        + Nonfunctional tests: check characteristics like performance and reliability.
            - Ex: load testing, stress testing
            - Ex: checking how many people can simultaneously sign up in to the app.

    - Tools write UI tests:
        + 1. Windows Application Driver (WinAppDriver)
        + 2. Selenium: Selenium is a portable open-source software-testing framework for web applications.
            - it supports all modern browsers.
            - can write Selenium tests in several programming languages, including C#.
            - can use NuGet packages that make it easy to run Selenium as NUnit tests.
        + 3. SpecFlow: SpecFlow is for .NET projects. It's inspired by a tool called Cucumber.
            - Both SpecFlow and Cucumber support behavior-driven development (BDD).
            - BDD uses a natural-language parser called **Gherkin** to help both technical teams and nontechnical teams define business rules and requirements.
            - can combine either SpecFlow or Cucumber with Selenium to build `UI tests`.

2. Test pyramid: 
    - (1) UI --> ... --> (2) Unit

3. Add unit tests to your application
    - Run the unit tests locally
        + 1. build project: `dotnet build --configuration Release`
        + 2. run unit tests: `dotnet test --configuration Release --no-build`
        + 3. write the results to a log file: use `--logger` option
            ```
            dotnet test Tailspin.SpaceGame.Web.Tests --configuration Release --no-build --logger trx
            ```
            - __TRX file__ (XML document) is created in __TestResults__ directory.
            -  __.gitignore__ file: __TRX__ file, __TestResults__ directory

    - Azure pipeline:
        + Built-in variable: __$(Agent.TempDirectory)__ output
        + Task: __publishTestResults__ argument is `--logger trx`

        + Azure DevOps --> select "Test Plans" --> select "Runs"
        + Build pipeline summary --> __Tests__ tab

4. Add a __testing widget__ ("Test Results Trend") to your dashboard
    - Azure DevOps project --> Overview --> select "Dashboards" --> select "Add a widget" with name __Test Results Trend__
        + setting "Gear" --> your "Build pipeline"

5. Add the __code coverage widget__ to the dashboard: __Code Coverage Widgets (published by Shane Davis)__
    - from __marketplace.visualstudio.com__: https://marketplace.visualstudio.com/
        + "Azure DevOps" tab --> search "code coverage" --> select "Code Coverage Widgets (published by Shane Davis)" --> select "Get it free"

    - Setting from "Gear": 
        + width: 2
        + Build definition: select your build pipeline
        + Coverage measurement: select "lines"

    - Azure Pipelines: Summary page -> Code Coverage tab, Tests tab.

6. Perform code coverage testing
    - __Coverlet__ is a cross-platform, code-coverage library for .NET.
        + https://github.com/tonerdo/coverlet

    - Coverlet usage note:
        + unit test project requires __coverlet.msbuild__ NuGet package: https://www.nuget.org/packages/coverlet.msbuild
        + Azure Pipelines supports __Cobertura__ and __JaCoCo__ coverage result formats: XML file
            - https://cobertura.github.io/cobertura
            - https://www.eclemma.org/jacoco
        + convert Cobertura coverage results to a format that's human-readable: use tool [ReportGenerator](https://github.com/danielpalme/ReportGenerator)
            - HTML format called "HtmlInline_AzurePipelines"

    - How can I manage .NET tools?
        + A .NET tool such as __ReportGenerator__ is a special NuGet package that contains a console application.
        + use a `manifest file` to manage local tools.
            - `dotnet tool restore`: to install local

    - Run code coverage locally
        + 1. create a local tool manifest file: `dotnet new tool-manifest`
        + 2. install __ReportGenerator__: `dotnet tool install dotnet-reportgenerator-globaltool`
        + 3. add the coverlet.msbuild package to test project: `dotnet add Tailspin.SpaceGame.Web.Tests package coverlet.msbuild`
        + 4. run your unit tests and collect code coverage:
            ``` .NET CLI (PS1)
            dotnet test --no-build --configuration Release `
                /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:CoverletOutput=./TestResults/Coverage/
            ```
        + 5. use ReportGenerator to convert the Cobertura file to HTML
            ```
            dotnet tool run reportgenerator `
                -- -reports:./Tailspin.SpaceGame.Web.Tests/TestResults/Coverage/coverage.cobertura.xml `
                -targetdir:./CodeCoverage `
                -reporttypes:HtmlInline_AzurePipelines
            ```
            - open __index.htm__ in __CodeCoverage__ folder.

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

## Manage build dependencies with Azure Artifacts
- Learn: https://learn.microsoft.com/en-us/training/modules/manage-build-dependencies
- Azure Artifacts: https://learn.microsoft.com/en-us/azure/devops/artifacts/?view=azure-devops

1. Concepts:
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

2. Set up Azure Artifacts
    1. Go to `Artifacts` tab, create feed name: `Tailspin.SpaceGame.Web.Models`
    2. Set permissions for Pipeline: __Contributor__ role, allow pipeline to feed package to artifact.
        - Users/Groups: search text `[project name] Build Service`, assign __Contributor__ role.

## Agile, Kanban, Scrum

- Azure DevOps: a project, a team, a board
    + Azure board: https://learn.microsoft.com/en-us/azure/devops/boards/?view=azure-devops
    
- sprints, work items

- Agile approach to software development, processes: Basic, CMMI, Agile, and Scrum process.
- Create project --> create work items --> associate work items with a sprint, or iteration

- delivery plans, manage work schedules across multiple teams
    + schedule milestone markers
    + Backlog items on Agile process, issues on Basic process
    + overall schedule

## Implement a code workflow in azure build pipeline by using Git and GitHub:

1. Add a build badge
    - "Organization settings" --> Pipelines --> Settings --> turn off "Disable anonymous access to badges".
    - "Project settings" --> Pipelines --> Settings --> turn off "Disable anonymous access to badges".
    - "Azure DevOps" --> Pipelines --> Your pipeline --> ellipsis (...) -> select "Status badge"
        + copy & add to Readme.md with message "Add build badge".

2. Track your build history: add a build history widget to the dashboard
    - "Azure DevOps" --> Overview --> Dashboards --> select "Add a widget" name __Build History__

3. Define Workflow: Code Workflow, Github workflow
    - Understanding the GitHub flow: https://docs.github.com/en/get-started/quickstart/github-flow
    - __A successful Git branching model__: https://nvie.com/posts/a-successful-git-branching-model
        + advanced branching and merging strategy
    - How to Split Pull Requests: https://www.thedroidsonroids.com/blog/splitting-pull-request
    - __How to Write a Git Commit Message__: https://chris.beams.io/posts/git-commit
    - Specify events that trigger pipelines: https://learn.microsoft.com/en-us/azure/devops/pipelines/build/triggers

## Run functional tests in Azure Pipelines: UI test

### Create Azure App Service environments: Dev, Test, and Staging
- 1. Select an Azure region: `eastasia` or `westus2`
    ``` PS1
    az account list-locations `
        --query "[].{Name: name, DisplayName: displayName}" `
        --output table`
    ```
- 2. set your default region: `az configure --defaults location=<REGION>`
- 3. Create the App Service instances: `Dev`, `Test`, and `Staging`
    + 1. generate a random number from Cloud Shell: 
        ```Bash
        webappsuffix=$RANDOM
        ```
    + 2. create a resource group named `tailspin-space-game-rg`
        ```
        az group create --name tailspin-space-game-rg --location eastasia

        az group list --output table
        ```

    + 3. create an App Service plan named `tailspin-space-game-asp`
        ```Azure CLI
        az appservice plan create --name tailspin-space-game-asp --resource-group tailspin-space-game-rg --sku F1 --is-linux
            --> --sku B1: Basic tier, F1: Free
            --> --is-linux: use Linux workers
        ```

    + 4. create the three App Service instances: `Dev`, `Test`, and `Staging` environments
        ```Azure CLI
        az webapp create --name tailspin-space-game-web-dev-001 --resource-group tailspin-space-game-rg --plan tailspin-space-game-asp --runtime "DOTNETCORE:6.0"

        az webapp create --name tailspin-space-game-web-test-001 --resource-group tailspin-space-game-rg --plan tailspin-space-game-asp --runtime "DOTNETCORE:6.0"

        az webapp create --name tailspin-space-game-web-staging-001 --resource-group tailspin-space-game-rg --plan tailspin-space-game-asp --runtime "DOTNETCORE:6.0"

        az webapp list --output table
        ```

    + 5. list the hostname and state of each App Service instance
        ```
        az webapp list --resource-group tailspin-space-game-rg --query "[].{hostName: defaultHostName, state: state}" --output table
        ```

### Create pipeline variables in Azure Pipelines: Dev, Test, and Staging stages
- 1. add the variables: 
    + From Azure DevOps project --> under "Pipelines" --> select "Library"
    + select `+ Variable group`: **Release** group name
        + Under "Properties" --> variable group name, enter "Release"
        + Under "Variables" --> select "+ Add"
            - "WebAppNameDev": "tailspin-space-game-web-dev-1234"
            - "WebAppNameTest": "tailspin-space-game-web-test-1234"
            - "WebAppNameStaging": "tailspin-space-game-web-staging-1234"

- 2. Create the dev, test, and staging environments: 
    + From Azure Pipelines --> select "Environments" --> create `dev`, `test`, and `staging` environment names.

- 3. Create a service connection: 
    + Service connection enables Azure Pipelines to access your Azure subscription. 
        - Azure Pipelines uses this service connection to deploy the website to App Service.

    + From Azure DevOps project --> select **Project settings**
        - Under "Pipelines", select **Service connections**
        - Select "New service connection", choose **Azure Resource Manager**
        - **Service principal (automatic)**
        - Fill fields:
            + Scope level: Subscription
            + Subscription: Your Azure subscription
            + Resource Group: **tailspin-space-game-rg**
            + Service connection name: `Resource Manager - Tailspin - Space Game`
        - Ensure select **Grant access permission to all pipelines**

### Plan the UI tests
```
git fetch upstream selenium
git checkout -B selenium upstream/selenium
dotnet build --configuration Release
dotnet run --configuration Release --no-build --project Tailspin.SpaceGame.Web
```

- Test browser: Chrome, Firefox, and Edge
- Microsoft-hosted Agent vs Self-hosted Agent: run jobs

### Write the UI tests
- Add the **IWebDriver** member variable
    + **IWebDriver**: is the programming interface that used to launch a web browser and interact with webpage content.
        + ChromeDriver, EdgeDriver, FirefoxDriver
        + Navigate, FindElement, and Close methods

- Define the test fixtures: **NUnit**, define the Setup method
    + **TestFixture** attribute. `Setup` method with `OneTimeSetup` attribute.
    + use **test fixtures** to run the entire set of tests multiple times, one time for each browser that we want to test on.

- Define the helper methods: FindElement and ClickElement methods
    + 1. Finding elements on the page, such as the links that we click and the modal windows that we expect to appear.
    + 2. Clicking elements on the page, such as the links that reveal the modal windows and the button that closes each modal.

        - ClickElement: `ChromeDriver`, `FirefoxDriver`, and `EdgeDriver` each implement **IJavaScriptExecutor**.
            + Selenium provides `IJavaScriptExecutor`: programmatically click links by using JavaScript.
        - FindElement: Selenium provides the **WebDriverWait** class.
            + To locate an element on the page, use the **By** class

- Define the test method
    + 1. Locate the link by its `id` attribute and then click the link.
    + 2. Locate the resulting modal.
    + 3. Close the modal.
    + 4. Verify that the modal was displayed successfully.

- Define test case data:
    + NUnit: **TestCase** attribute

- Locators in Selenium: a locator selects an HTML element from the DOM (Document Object Model) to act on.
    + locate an HTML element:
        - 1. `id` attribute.
        - 2. `name` attribute.
        - 3. XPath expression.
        - 4. Link text or partial link text.
        - 5. Tag name, such as `body` or `h1`.
        - 6. CSS class name.
        - 7. CSS selector.

### Run the UI tests locally
1. Install the Selenium driver for **Microsoft Edge**: Notice browser and browser driver VERSION
    - The NuGet package for Chrome and Firefox installs driver software under the **bin** directory, alongside the compiled test code. 
        + For Edge, you need to manually install the driver.
    
    - step 1: Open **Edge** and navigate to **edge://settings/help**: Notice **Version 133.0.3065.59 (Official build) (64-bit)**
    - step 2. Navigate to **Microsoft Edge Driver downloads**: https://developer.microsoft.com/microsoft-edge/tools/webdriver/#downloads?azure-portal=true
        + __download the driver that matches the Edge version number__ (133.0.3065.59)

    - step 3. Extract the `.zip` file to the `bin/Release/net6.0` directory under your project's `Tailspin.SpaceGame.Web.UITests` directory

    1. Chrome Driver: **Version 132.0.6834.160 (Official Build) (64-bit)**
        - https://developer.chrome.com/docs/chromedriver/downloads

2. Export environment variables:
    - For each driver, have the environment variable that maps to the location of that driver.
        + 1. CHROMEWEBDRIVER: C:\SeleniumWebDrivers\ChromeDriver
        + 2. EDGEWEBDRIVER: C:\SeleniumWebDrivers\EdgeDriver
        + 2. GECKOWEBDRIVER: C:\SeleniumWebDrivers\GeckoDriver

        ``` Bash
        driverDir="C:\Practice\Practice\LEARN\mslearn-tailspin-spacegame-web-deploy\Tailspin.SpaceGame.Web.UITests\bin\Release\net6.0"

        export ChromeWebDriver=$driverDir
        export EdgeWebDriver=$driverDir
        export GeckoWebDriver=$driverDir

        export SITE_URL="http://localhost:5000"
        ```

        ``` PS1
        $driverDir="C:\Practice\Practice\LEARN\mslearn-tailspin-spacegame-web-deploy\Tailspin.SpaceGame.Web.UITests\bin\Release\net6.0"

        $env:ChromeWebDriver="C:\Practice\Practice\LEARN\mslearn-tailspin-spacegame-web-deploy\Tailspin.SpaceGame.Web.UITests\bin\Release\net6.0"
        $env:EdgeWebDriver="C:\Practice\Practice\LEARN\mslearn-tailspin-spacegame-web-deploy\Tailspin.SpaceGame.Web.UITests\bin\Release\net6.0"
        $env:GeckoWebDriver="C:\Practice\Practice\LEARN\mslearn-tailspin-spacegame-web-deploy\Tailspin.SpaceGame.Web.UITests\bin\Release\net6.0"

        $env:SITE_URL="http://localhost:5000"
        ```

### Run the UI tests locally
- step 1. run app
    ```
    dotnet build --configuration Release
    dotnet run --configuration Release --no-build --project Tailspin.SpaceGame.Web
    ```

- step 2: Export the SITE_URL environment variable
    ```
    export SITE_URL="http://localhost:5000"
    ```

- step 3: Run the UI tests
    ```
    dotnet test --configuration Release Tailspin.SpaceGame.Web.UITests
    ```

### Run UI tests in the Pipeline
1. Add the **SITE_URL** variable to Azure Pipelines
    - **SITE_URL**: https://tailspin-space-game-web-test.azurewebsites.net
    - steps: Pipelines --> Library --> Release --> Variables --> "+ Add"

2. Modify the pipeline configuration

### Learn more about tests
1. About NUnit
    - NUnit.org: https://nunit.org/
    - Unit test tools and tasks: https://learn.microsoft.com/en-us/visualstudio/test/unit-test-your-code
    - Unit testing C# with NUnit and .NET Core: https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-with-nunit

2. About parallel jobs: run tests on Windows, MacOS, and Linux platforms
    - Jobs: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/phases?tabs=yaml
    - Parallel jobs: https://learn.microsoft.com/en-us/azure/devops/pipelines/licensing/concurrent-jobs

3. About Selenium tests: UI tests
    - SeleniumHQ.org: https://www.seleniumhq.org/
    - Selenium IDE: https://www.seleniumhq.org/selenium-ide
    - UI test with Selenium: https://learn.microsoft.com/en-us/azure/devops/pipelines/test/continuous-test-selenium
    - UI testing considerations: https://learn.microsoft.com/en-us/azure/devops/pipelines/test/ui-testing-considerations?tabs=mstest
    - Use WebDriver to automate Microsoft Edge: https://learn.microsoft.com/en-us/microsoft-edge/webdriver-chromium

### Improve **code quality** by using **Azure Test Plans**
- Azure test plans: https://learn.microsoft.com/en-us/azure/devops/test/?view=azure-devops
- Azure test plans is tool to create and run manual test plans, generate automated tests, and collect feedback from users.
1. Manage test plans, test suites, and test cases: three main types of test-management artifacts
    - **Test plans** group together test suites and individual test cases.
        + Test plans include static test suites, requirement-based suites, and query-based suites.
    - **Test suites** group test cases into separate testing scenarios within a single test plan.
    - **Test cases** validate individual parts of your code or app deployment.

2. Use the Test & Feedback extension: 
    - Docs & extension:
        + https://learn.microsoft.com/en-us/azure/devops/test/perform-exploratory-tests
        + https://marketplace.visualstudio.com/items?itemName=ms.vss-exploratorytesting-web

    - Capture - rich diagnostic data: comments, screenshots with annotations, and audio or video recordings that describe your findings and highlight issues.
    - Create - work items such as bugs, tasks, and test cases from within the extension.
    - Collaborate - with your team by sharing your findings.

## Run nonfunctional tests in Azure Pipelines

- check characteristics like performance and reliability
- determine the application's performance under both realistic and heavy loads.
- Does your app expose any loopholes or weaknesses that might cause an information breach?
- Nonfunctional tests answer questions:
    + How does the application perform under normal circumstances?
    + How does the application perform when many users sign in concurrently?
    + How secure is the application?

### kinds of nonfunctional tests
- 1. Performance testing:
    + The goal of performance testing is to improve an application's speed, scalability, and stability.
        - Testing for speed determines how quickly an application responds.
        - Testing for scalability determines the maximum user load an application can handle.
        - Testing for stability determines whether the application remains stable under different loads.
    + Two common types of performance tests are **load tests** and **stress tests**.

    + 1. Load testing: determine an application's performance under realistic loads.
        - Ex: 
            + load tests can determine how well an application performs at the upper limit of its service-level agreement (SLA).
            + load testing determines the application's behaviors when multiple users need it at the same time.
            + a load test for printer software might send the application large amounts of data.
            + A load test for a mail server might simulate thousands of concurrent users.
            + to uncover problems that exist only when the application is operating at its limits.
                - issues such as buffer overflow and memory leaks can surface.

    + 2. Stress testing: determine an application's stability and robustness under heavy loads.
        - Ex:
            + The stress tests determine whether the application will crash under these loads.
                - If the application fails, the stress test checks to ensure that it fails gracefully.
                - A **graceful failure** might issue an appropriate, informative error message.
            + In case your video goes viral, you'll want to know how well the servers can handle the extra load.
            + Another typical scenario is high traffic on shopping websites during holiday seasons.

- 2. Security testing: ensures that applications are free from vulnerabilities, threats, and risks.
    + Ex:
        - finds all the system's possible loopholes and weaknesses that might cause an information breach or a loss of revenue.
    + Two types of in many types of Security testing are **penetration testing** and **compliance testing**

    + 1. Penetration testing (pen testing): tests the insecure areas of the application
        - Ex:
            + tests for vulnerabilities that an attacker could exploit.
            + An authorized, simulated cyber attack is usually a part of penetration testing.

    + 2. Compliance testing: determines whether an application is compliant with some set of requirements, inside or outside the company.
        - Ex:
            + healthcare organizations usually need to comply with HIPAA (Health Insurance Portability and Accountability Act of 1996), which provides data privacy and, security provisions for safeguarding medical information

### Plan load tests by using Apache JMeter
- use Apache JMeter to simulate multiple users who access the web app simultaneously.
- The tests fetch the web content from the app that runs on Azure App Service in the *Staging* environment.
- **Apache JMeter** is an open-source load-testing tool that analyzes and measures performance.
    + The report it generates is an XML file.

- Run load tests from Apache JMeter
    + 1. Create the test plan: use Apache JMeter tool on Linux. **LoadTest.jmx**
        - will export a test plan: **LoadTest.jmx**
            + Add a thread Group: number of users and number of each user's requests.
                - Ex: 10 simulated users (threads), each user makes 10 request, so the system gets a total of 100 requests.

    + 2. Run the test plan: **Results.xml**
        ```command line
        apache-jmeter-5.4.1/bin/./jmeter -n -t LoadTest.jmx -o Results.xml
            -n non-GUI mode
            -t test plan file, LoadTest.jmx
            -o report file, Results.xml
        ```
        - Report file:
            + "t": response time in milliseconds.
        - Pipeline support: CTest, JUnit (including PHPUnit), NUnit 2, NUnit 3, Visual Studio Test (TRX), and xUnit 2.
            + write an *XSLT* file that converts the *JMeter results* to *JUnit*

    + 3. Transform the report to **JUnit**: be able understand by Azure Pipelines. **XSLT** file & **xsltproc** CLI tool
        - **XSLT** stands for `XSL Transformations`, or `eXtensible Stylesheet Language Transformations`. 
            + An XSLT file resembles an XML file, but it enables you to transform an XML document to another XML format.

            + Recall our requirements for load tests:
                - 1. The average request time should be less than one second.
                - 2. No more than 10 percent of requests should take more than one second.

            + XSLT collects the following data from the JMeter output:
                - 1. Each HTTP request time: **./httpSample/@t**
                    + It collects this data by selecting the `t` attribute from each `httpSample` element. (**./httpSample/@t**)

                - Each failure message: **./httpSample/assertionResult/failureMessage**
                    + It collects this data by selecting all failureMessage nodes from the document. (**./httpSample/assertionResult/failureMessage**)

        - **xsltproc**: a command-line tool for applying XSLT stylesheets to XML documents.
            + install xsltproc: 
                ``` Bash
                sudo apt-get install xsltproc
                ```

            + run `xsltproc` to transform the **JMeter report** to **JUnit**
                ```Bash
                xsltproc JMeter2JUnit.xsl Results.xml > JUnit.xml
                ```

### Run load tests in Azure Pipelines
1. Fetch the branch from GitHub
    ```
    git fetch upstream jmeter
    git checkout -B jmeter upstream/jmeter
    ```

2. Add variables to Azure Pipelines: variable group name **Release**
    - STAGING_HOSTNAME: tailspin-space-game-web-staging-0001.azurewebsites.net
    - jmeterVersion: 5.4.3
    - WebAppNameDev: tailspin-space-game-web-dev-0001
    - WebAppNameTest: tailspin-space-game-web-test-0001
    - WebAppNameStaging: tailspin-space-game-web-staging-0001

3. Add Environments to Azure Pipelines: dev, test, and staging

4. Modify the pipeline configuration and push code:
    ```
    git add azure-pipelines.yml
    git commit -m "Run load tests with Apache JMeter"
    git push origin jmeter
    ```

### Learn More
- Performance testing in Apache JMeter:
    + JMeter.Apache.org: https://jmeter.apache.org/
    + Apache JMeter - User's manual: Best practices: https://jmeter.apache.org/usermanual/best-practices.html

## Manage release cadence in Azure Pipelines by using deployment patterns

### Deployment Patterns
1. Blue-green deployments:
    - reduces risk and downtime by running two identical environments.
        + These environments are called **blue** and **green**.
    - gives us a fast way to do a rollback.

2. Canary releases
    - is a way to identify potential problems early without exposing all users to the issue.

3. Feature toggles
    - Use feature toggles to "flip a switch" at runtime.
        + We can deploy new software without exposing any other new or changed functionality to our users.

    - A big advantage to the feature toggles pattern is that it helps us avoid too much branching. 
        + Merging branches can be painful.

4. Dark launches
    - is similar to a `canary release` or switching a `feature toggle`.
        + Rather than expose a new feature to everyone, in a `dark launch` we release the feature to a small set of users.

5. A/B testing
    - compares two versions of a webpage or app to determine which one performs better.

6. Progressive-exposure deployment (ring-based deployment)
    - It's another way to limit how changes affect users while making sure those changes are valid in a production environment.
    - In a ring-based deployment, we deploy changes to risk-tolerant customers first.
        + Then we progressively roll out to a larger set of customers.

### Implement the blue-green deployment pattern: using deployment slot in Azure App Service

1. Add a deployment slot
    - By default, every `App Service instance` provides a **default slot**, named **production**.

    - Step 1: to get the name of the App Service instance corresponds to *Staging* and to store the result in a Bash variable named *staging*
        ``` Bash
        staging=$(az webapp list --resource-group tailspin-space-game-rg --query "[?contains(@.name, 'tailspin-space-game-web-staging')].{name: name}" --output tsv)
        
        echo $staging
        ```
        + `--query` argument uses [JMESPath](http://jmespath.org/) - a query language for JSON.

    - Step 2: add **swap** slot name to **staging** environment
        ``` Azure CLI
        az webapp deployment slot create --name $staging --resource-group tailspin-space-game-rg --slot swap
        ```

    - Step 3: to list deployment slot's host name
        ```
        az webapp deployment slot list --name $staging --resource-group tailspin-space-game-rg --query [].hostNames --output tsv

            --> result resembles: tailspin-space-game-web-staging-001-swap.azurewebsites.net
        ```

2. Swap deployment slots in Staging
    - Step 4: Modify pipeline azure-pipelines.yml
        + Swap deployment slots in Staging
        + use the **AzureAppServiceManage@0** task: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-app-service-manage
            - it is able to start, stop, or delete a slot.
            - `action`: to start, stop, or delete a slot.

    - Step 5: Commit the changes, and then push the branch up to GitHub
        ```
        git add azure-pipelines.yml
        git commit -m "Swap deployment slots"
        git push origin blue-green
        ```

3. Revert the change through the pipeline
    - Step 6: Revert the change: swapping **production slot** and **swap slot**
        + 1. swap the slots manually through the Azure portal.
        + 2. roll forward by pushing another change through the pipeline.

        + Step 1: view your commit history
            ```Bash
            git --no-pager log --oneline
            ```

        + Step 2: revert by one commit
            ```
            git revert --no-edit HEAD
            ```
            - Think of HEAD as the current state of your branch. HEAD refers to the latest commit. 
                + This command specifies to revert only the HEAD, or latest, commit

        + Step 2: run 'git log' again and push code
            ```
            git push origin blue-green
            ```

## Assess your existing software development process
- value-stream mapping: https://learn.microsoft.com/en-us/training/modules/assess-your-development-process/4-assess-process-efficiency
- Recall equation (formula):
    + **activity ratio** (or **efficiency**) = **process time** divided by **total lead time**

    + Now: "activity ratio" = 5 days / 10 days = 0.50
        - we get a **50 percent reduction**.
        - The team spends less time waiting and more time doing what they enjoy most: delivering features that they know their customers will love.

- The team first reduced some inefficiencies when they implemented continuous integration (CI). 
    + By applying continuous delivery (CD), they have now reduced inefficiencies even further.

    1. Implemented continuous integration (CI), the team reduced:
        - 1. The time it takes to set up source control for new features. The required time went from `three days` to `zero days`.
            + The team achieved this improvement by moving from centralized source control to Git, a form of distributed source control. 
                - By using distributed source control, they don't need to wait for files to be unlocked.

        - 2. The time it takes to deliver code to Amita, the tester. The required time went from `two days` to `zero days`.
            + The team achieved this improvement by moving their build process to Azure Pipelines.
                - Azure Pipelines automatically notifies Amita when a build is available.
                - Developers no longer need to update Amita's spreadsheet to notify her.

        - 3. The time it takes Amita to test new features. The required time went from `three days` to `one day`.
            + The team achieved this improvement by unit-testing their code. 
                - They run unit tests each time a change moves through the build pipeline, so fewer bugs and regressions reach Amita. 
                - The reduced workload means that Amita can complete each manual test faster.

    2. Applying continuous delivery (CD), the team reduced: The release pipeline
        - 1. The time it takes to get the build into the Test stage. The required time went from `three days` to `one day`.
            + The team achieved this by using a scheduled trigger to deploy to Test every day at 3:00 AM.

        - 2. The time it takes to get the tested build into Staging. The required time went from `two days` to `zero days`.
            + The team achieved this improvement by adding Selenium UI tests, a form of functional testing, to the Test stage. 
                - These automated tests are much faster than the manual versions.

        - 3. The time it takes to get the approved build from Staging to live. The required time went from `one day` to `less than one day`.
            + The team achieved this improvement by adding manual approval checks to the pipeline.
                - When management signs off, Tim can release the changes from Staging to live.

## Automate Azure Functions deployments with Azure Pipelines

1. Create the Azure App Service and Azure Functions environments
    1. Create three globally unique names for your App Service, Azure Function, and storage accounts
        ```Option, Bash 
        resourceSuffix=$RANDOM
        ```

        ```PS1
        $resourceSuffix="001"
        $webName="tailspin-space-game-web-${resourceSuffix}"
        $leaderboardName="tailspin-space-game-leaderboard-${resourceSuffix}"
        $storageName="tailspinspacegame${resourceSuffix}"

        $rgName='tailspin-space-game-rg'
        $planName='tailspin-space-game-asp'
        ```

    2. create a resource group
        ``` Azure CLI
        az group create --name $rgName
        ```

    3. create an App Service plan
        ``` Azure CLI
        az appservice plan create --name $planName --resource-group $rgName --sku F1 --is-linux
        ```

    4. create the App Service instance
        ``` Azure CLI
        az webapp create --name $webName --resource-group $rgName --plan $planName --runtime "DOTNETCORE:6.0"
        ```

    5. Azure Functions requires a storage account for deployment
        ``` Azure CLI
        az storage account create --name $storageName --resource-group $rgName --sku Standard_LRS

            --sku: Premium_LRS, Premium_ZRS, 
                    Standard_GRS, Standard_GZRS, Standard_LRS,
                    Standard_RAGRS (default), Standard_RAGZRS, Standard_ZRS
        ```

    6. create the Azure Functions app instance
        ```Azure CLI
        az functionapp create --name $leaderboardName --resource-group $rgName --storage-account $storageName --functions-version 4 --consumption-plan-location eastasia
        
        location: eastasia
            az account list-locations --query "[].{Name: name, DisplayName: displayName}" --output table
            az configure --defaults location=<REGION>
        ```

    7. list the host name and state of the App Service instance and Function App instance
        ```
        az webapp list --resource-group $rgName --query "[].{hostName: defaultHostName, state: state}" --output table

        az functionapp list --resource-group $rgName --query "[].{hostName: defaultHostName, state: state}" --output table
        ```

2. Create pipeline variables in Azure Pipelines
    1. add a variable group to your project: named "Release"
        - Step 1. From `Space Game - web - Azure Functions` project
            + select "Pipelines", then select "Library"

        - Step 2. Add variables:
            + WebAppName: tailspin-space-game-web-001
            + LeaderboardAppName: tailspin-space-game-leaderboard-001
            + ResourceGroupName: tailspin-space-game-rg

3. Create the **spike** environment
    - From the Azure DevOps menu, under **Pipelines**, select **Environments**

4. Create a service connection
    - From "Space Game - web - Azure Functions" project, select **Project settings**
    - Create a service connection:
        + select **Azure Resource Manager**
        + select **Service principal (automatic)**
        + In the **New Azure service connection** pane
            - Scope level:	**Subscription**
            - Subscription:	Select your Azure subscription
            - Resource Group:	**tailspin-space-game-rg**
            - Service connection name:	**Resource Manager - Tailspin - Space Game**

        + Ensure **Grant access permission to all pipelines** is selected.

5. Test build & release
    - webapp: http://tailspin-space-game-web-001.azurewebsites.net/
    - functionapp: http://tailspin-space-game-leaderboard-001.azurewebsites.net/api/LeaderboardFunction?pageSize=10

6. Learn More
    - Key serverless options including `Azure Functions`, `Microsoft Flow`, `Azure Logic Apps`, and `Azure App Service WebJobs`
        + Choose the right integration and automation services in Azure: 
            - https://learn.microsoft.com/en-us/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs
    
    - Different options for **microservices** on Azure, including `Azure Functions`, `Kubernetes`, and `Service Fabric`
        + Choosing an Azure compute option for microservices: 
            - https://learn.microsoft.com/en-us/azure/architecture/microservices/design/compute-options

    - Different compute offerings that cover virtually every cloud scenario
        + Choose an Azure compute service for your application:
            - https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree