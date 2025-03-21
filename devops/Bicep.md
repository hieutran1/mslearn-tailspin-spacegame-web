# Bicep
1. Part 1: Fundamentals of Bicep: https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/
2. Part 2: Intermediate Bicep: https://learn.microsoft.com/en-us/training/paths/intermediate-bicep/
3. Part 3: Advanced Bicep: https://learn.microsoft.com/en-us/training/paths/advanced-bicep/

- After that, you might be interested in adding your Bicep code to a deployment pipeline.
    + Take one of these two learning paths based on the tool you want to use:
4. Adding Bicep code to a deployment pipeline:
    1. Option 1: Deploy Azure resources by using Bicep and Azure Pipelines
        - https://learn.microsoft.com/en-us/training/paths/bicep-azure-pipelines/
    2. Option 2: Deploy Azure resources by using Bicep and GitHub Actions
        - https://learn.microsoft.com/en-us/training/paths/bicep-github-actions/

## Introduction to infrastructure as code using Bicep
- https://learn.microsoft.com/en-us/training/modules/introduction-to-infrastructure-as-code-using-bicep

1. Introduction
    1. Introduction
    2. Example scenario
        - Suppose you work as an Azure infrastructure administrator at a toy company that's experiencing significant growth in the global market. As a result, your infrastructure needs to scale with the company's growth, including:
          + Deployments of new applications for internal teams and customers.
          + Multiple region deployments to support your customers and partners around the world.
          + Multiple environment deployments to ensure consistency.

        - You're asked to evaluate whether infrastructure as code might be a valuable approach to resource provisioning at your company. 
        - You also need to decide which technology to use when you deploy your Azure infrastructure.

2. What is infrastructure as code?
    - You're asked to evaluate whether infrastructure as code might be a valuable approach to resource provisioning at your company. You're reviewing the available options for deployment, including:
      + Azure portal
      + Azure CLI
      + Azure PowerShell
      + Azure Resource Manager templates (JSON and Bicep)

    1. Defining infrastructure as code
        - Infrastructure as code is the process of automating your infrastructure provisioning.
        - It uses a descriptive coding language and versioning system that's similar to what's used for source code.
        - When you create an application, your source code generates the same result each time you compile it.
        - In a similar manner, infrastructure-as-code deployments are automated, consistent, and repeatable.
        - Infrastructure as code can automate the deployments of your infrastructure resources, like virtual networks, virtual machines, applications, and storage.

    2. Why use infrastructure as code?
        - Adopting an infrastructure as code approach offers many benefits to resource provisioning. With infrastructure as code, you can:
          + Increase confidence in your deployments.
          + Manage multiple environments.
          + Better understand your cloud resources.

    3. Imperative and declarative code

3. What is Azure Resource Manager?
    1. Azure Resource Manager concepts
        - Azure Resource Manager is the service that's used to deploy and manage resources in Azure.
        - You can use Resource Manager to create, update, and delete resources in your Azure subscription.
        - You can interact with Resource Manager by using many tools, including the Azure portal.
        - Resource Manager also provides a series of other features, like access control, auditing, and tagging, to help manage your resources after deployment.

        1. Terminology
            1. **Resource**: A manageable item that's available on the Azure platform. 
                - Virtual networks, virtual machines, storage accounts, web apps, and databases are examples of resources.

            2. **Resource group**: A logical container that holds related resources for an Azure solution.

            3. **Subscription**: A logical container and billing boundary for your resources and resource groups. 
                - Each Azure resource and resource group is associated with only one subscription.

            4. **Management group**: A logical container that you use to manage more than one subscription.
                - You can define a hierarchy of management groups, subscriptions, resource groups, and resources to efficiently manage access, policies, and compliance through inheritance.

            5. **Azure Resource Manager template (ARM template)**: A template file that defines one or more resources to deploy to a resource group, subscription, management group, or tenant.
                - You can use the template to deploy the resources in a consistent and repeatable way.
                - There are two types of ARM template files: JSON and Bicep

        2. Benefits
            - Resource Manager provides many benefits and capabilities related to infrastructure-as-code resource provisioning:
              + You can deploy, manage, and monitor the resources in your solution as a group instead of individually.
              + You can redeploy your solution throughout the development lifecycle and have confidence that your resources are deployed in a consistent state.
              + You can manage your infrastructure through declarative templates instead of by using scripts.
              + You can specify resource dependencies to ensure that resources are deployed in the correct order.

        3. Operations: Control plane and data plane
            - You can execute two types of operations in Azure: control plane operations and data plane operations. 
              + Use the control plane to manage the resources in your subscription.
              + Use the data plane to access features that are exposed by a resource.

            - For example, you use a control plane operation to create a virtual machine, but you use a data plane operation to connect to the virtual machine by using Remote Desktop Protocol (RDP).

            1. Control plane
                - When you send a request from any of the Azure tools, APIs, or Software Development Kits (SDKs), Resource Manager receives, authenticates, and authorizes the request. 
                - Then, it sends the request to the Azure resource provider, which takes the requested action.
                - Because all requests are handled through the same API, you see consistent results and capabilities in all the different tools that are available in Azure.

                - All control plane operation requests are sent to a Resource Manager URL. 
                - For example, the create or update operation for virtual machines is a control plane operation. 
                - Here's the request URL for this operation:
                  ```
                  PUT https://management.azure.com/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Compute/virtualMachines/{virtualMachineName}?api-version=2022-08-01
                  ```

                - Resource Manager understands the difference between these requests and doesn't create identical resources or delete existing resources, although there are ways to override this behavior

            2. Data plane
                - When a data plane operation starts, the requests are sent to a specific endpoint in your Azure subscription. 
                - For example, the Detect Language operation in Azure AI services is a data plane operation because the request URL is:
                  ```
                  POST https://eastus.api.cognitive.microsoft.com/text/analytics/v2.0/languages
                  ```

    2. What are ARM templates?
        - Azure Resource Manager templates are files that define the infrastructure and configuration for your deployment.
        - When you write an ARM template, you take a declarative approach to your resource provisioning. 
        - These templates describe each resource in the deployment, but they don't describe how to deploy the resources.
        -  When you submit a template to Resource Manager for deployment, the control plane can deploy the defined resources in an organized and consistent manner.

        1. Why use ARM templates?
            - There are many benefits to using ARM templates, either JSON or Bicep, for your resource provisioning:
              + **Repeatable results**: ARM templates are idempotent, which means that you can repeatedly deploy the same template and get the same result. The template doesn't duplicate resources.
              + **Orchestration**: When a template deployment is submitted to Resource Manager, the resources in the template are deployed in parallel.
              + **Preview**: The what-if tool, available in Azure PowerShell and Azure CLI, allows you to preview changes to your environment before template deployment. 
                - This tool details any creations, modification, and deletions that are made by your template.

              + **Testing and Validation**: You can use tools like the Bicep linter to check the quality of your templates before deployment.
                - ARM templates submitted to Resource Manager are validated before the deployment process.
                - This validation alerts you to any errors in your template before resource provisioning.

              + **Modularity**: You can break up your templates into smaller components and link them together at deployment.

              + **CI/CD integration**: Your ARM templates can be integrated into multiple CI/CD tools, like Azure DevOps and GitHub Actions.
                - You can use these tools to version templates through source control and build release pipelines.

              + **Extensibility**: With deployment scripts, you can run Bash or PowerShell scripts from within your ARM templates.
                - These scripts perform tasks, like data plane operations, at deployment. 
                - Through extensibility, you can use a single ARM template to deploy a complete solution.

        2. JSON and Bicep templates
            - Two types of ARM templates are available for use today: JSON templates and Bicep templates.
              + JavaScript Object Notation (JSON) is an open-standard file format that multiple languages can use. 
              + Bicep is a new domain-specific language that was recently developed for authoring ARM templates by using an easier syntax.
              + You can use either template format for your ARM templates and resource deployments.

4. What is Bicep?

    1. Bicep language
        - Bicep is a Resource Manager template language that's used to declaratively deploy Azure resources. 
        - Bicep is designed for a specific scenario or domain, which makes it a domain-specific language.
    2. Benefits of Bicep
        - Simpler syntax
        - Modules: You can break down complex template deployments into smaller module files and reference them in a main template.
        - Automatic dependency management: Bicep automatically detects dependencies between your resources
        - Type validation and IntelliSense: The Bicep extension for Visual Studio Code features rich validation and IntelliSense for all Azure resource type API definitions

5. How Bicep works
    1. Bicep deployment
        - For example, the following command deploys a Bicep template to a resource group named storage-resource-group:
          ```
          az deployment group create --template-file main.bicep --resource-group storage-resource-group
          ```

        - You can view the JSON template you submitted to Resource Manager by using the bicep build command. In the next example, a Bicep template is converted into its corresponding JSON template:
          ```
          bicep build main.bicep
          ```

6. When to use Bicep
    1. Is Bicep the right tool?
        - There are many reasons to choose Bicep as the main tool set for your infrastructure-as-code deployments. 
        - For Azure deployments, Bicep has some advantages, but Bicep doesn't work as a language for other cloud providers.

    2. When is Bicep the right tool?
        - If you use Azure as your cloud platform, consider these advantages of using Bicep:
            + Azure-native: With Bicep, you're using a language that is native to Azure.
            + Azure integration: Azure Resource Manager (ARM) templates, both JSON and Bicep, are fully integrated within the Azure platform.
            + Azure support: Bicep is a fully supported product with Microsoft Support.
            + No state management: Bicep deployments compare the current state of your Azure resources with the state that you define in the template. 
              - You don't need to keep your resource state information somewhere else, like in a storage account. 
              - Azure automatically keeps track of this state for you.
            + Easy transition from JSON: If you already use JSON templates as your declarative ARM template language, it isn't a difficult process to transition to using Bicep. 
              - You can use the Bicep CLI to decompile any ARM template into a Bicep template by using the **bicep decompile** command

    3. When is Bicep not the right tool?
        - Existing tool set: When you're determining when to use Bicep, the first question to ask is, does my organization already have a tool set in use? 
        - Multicloud: If your organization uses multiple cloud providers to host its infrastructure, Bicep might not be the right tool. 
          + Other cloud providers don't support Bicep as a template language. 
          + Open source tools like Terraform can be used for multicloud deployments, including deployments to Azure.

## Build your first Bicep template
1. Example scenario
    - Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. 
    - You'll host the website in Azure using Azure App Service.
      + You'll incorporate a storage account for files, such as manuals and specifications, for the toy.

2. What is Bicep?
    1. How is Bicep related to ARM templates?
    2. What do I need to install?
        - extension for writing Bicep templates: https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep

3. Define resources
    - Your toy company needs you to create a reusable Bicep template for product launches. 
    - The template needs to deploy an Azure storage account and Azure App Service resources, which will be used for the marketing of each new product during its launch.

    1. Define a resource
        - This example creates a storage account named **toylaunchstorage**:
            ```yml
            resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
              name: 'toylaunchstorage'
              location: 'westus3'
              sku: {
                name: 'Standard_LRS'
              }
              kind: 'StorageV2'
              properties: {
                accessTier: 'Hot'
              }
            }
          ```
          - The **resource** keyword at the start tells Bicep that you're about to define a resource
          - Next, you give the resource a *symbolic name*. 
            + In the example, the resource's symbolic name is **storageAccount**.
            + Symbolic names are used within Bicep to refer to the resource, but they won't ever show up in Azure.
          - **Microsoft.Storage/storageAccounts@2022-09-01** is the *resource type* and *API version* of the resource.
            + **Microsoft.Storage/storageAccounts** tells Bicep that you're declaring an Azure storage account. 
            + The date **2022-09-01** is the version of the Azure Storage API that Bicep uses when it creates the resource.
          - You have to declare a **resource name**, which is the name the storage account will be assigned in Azure. 
            + You'll set a resource name using the **name** keyword.
          - You'll then set other details of the resource, such as its location, SKU (pricing tier), and kind

          - NOTICE: Resource names often have rules you must follow, like maximum lengths, allowed characters, and uniqueness across all of Azure.
            + The requirements for resource names are different for each Azure resource type. 
            + Be sure to understand the naming restrictions and requirements before you add them to your template.

    2. What happens when resources depend on each other?
        - You'll need to deploy an App Service app for the template that will help launch the toy product, but to create an App Service app, you first need to create an App Service plan. 
        - The App Service plan represents the server-hosting resources, and it's declared like this example:
          ```yml
          resource appServicePlan 'Microsoft.Web/serverFarms@2023-12-01' = {
            name: 'toy-product-launch-plan'
            location: 'westus3'
            sku: {
              name: 'F1'
            }
          }
          ```
          + App Service plan that has the resource type **Microsoft.Web/serverFarms**
          + The plan resource is named **toy-product-launch-plan**, 
          + and it's deployed into the West US 3 region. 
          + It uses a pricing SKU of F1, which is App Service's free tier.

        - Now that you've declared the App Service plan, the next step is to declare the app:
          ```yml
          resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
            name: 'toy-product-launch-1'
            location: 'westus3'
            properties: {
              serverFarmId: appServicePlan.id
              httpsOnly: true
            }
          }
          ```
          + **serverFarmId: appServicePlan.id**: Bicep will get the App Service plan's *resource ID* using the **id** property.
            - NOTICE: In Azure, a **resource ID** is a unique identifier for each resource.
              + The resource ID includes the Azure subscription ID, the resource group name, and the resource name, along with some other information.

          + By declaring the app resource with a property that references the plan's symbolic name, Azure understands the implicit dependency between the App Service app and the plan.

4. Exercise - Define resources in a Bicep template
    1. Create a Bicep template that contains a storage account
        1. Create a new file called **main.bicep**
            ```Bicep
            resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
              name: 'toylaunchstorage'
              location: 'eastus'
              sku: {
                name: 'Standard_LRS'
              }
              kind: 'StorageV2'
              properties: {
                accessTier: 'Hot'
              }
            }
            ```
            - NOTICE: Update the name of the storage account from **toylaunchstorage** to something that's likely to be unique, because every storage account needs a globally unique name. 
              + Make sure the name is 3 to 24 characters and includes only lowercase letters and numbers.

    2. Deploy the Bicep template to Azure
        - go to the directory where you saved your template. 
        - For example, if you saved your template in the **templates** folder, you can use this command:
          ```Azure PowerShell
          Set-Location -Path templates
          ```
          ```Azure CLI, Bash
          cd templates
          ```

        1. Install the Bicep CLI
            - To use Bicep from Azure PowerShell, install the Bicep CLI.
              + https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#azure-powershell 

            ```Azure CLI
            az bicep install && az bicep upgrade
            ```

        2. Sign in to Azure by using Azure PowerShell
            1. In the Visual Studio Code terminal
                ```Azure PS
                Connect-AzAccount
                ```
                ```Azure CLI
                az login
                ```

                - A browser opens so that you can sign in to your Azure account. The browser might be opened in the background.

            2. After you've signed in to Azure, the terminal displays a list of the subscriptions associated with this account
                - If you've used more than one sandbox recently, the terminal might display more than one instance of Concierge Subscription. - In this case, use the next two steps to set one as the default subscription:
                  1. Get the subscription ID: 
                      ```Azure PS
                      Get-AzSubscription
                      ```

                  2. Change your active subscription to Concierge Subscription
                      ```Azure PS
                      $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
                      Set-AzContext $context
                      ```

                      - Get the Concierge Subscription IDs
                      ```Azue CLI
                      az account list --refresh --query "[?contains(name, 'Concierge Subscription')].id" --output table

                      az account set --subscription {your subscription ID}
                      ```

        3. Set the default resource group
            ```Azure PS
            Set-AzDefault -ResourceGroupName [sandbox resource group name]
            ```

            ```Azure CLI
            az configure --defaults group="[sandbox resource group name]"
            ```

        4. Deploy the template to Azure
            ```Azure PS
            New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep
            ```

            ```Azure CLI
            az deployment group create --name main --template-file main.bicep
            ```

    3. Verify the deployment
        1. In **Overview**, you can see that one deployment succeeded
        2. Select **1 Succeeded** to see the details of the deployment 
        3. Select the deployment called **main** to see which resources were deployed, then select Deployment details to expand it.

        - You can also verify the deployment from the command line
            ```Azure PS
            Get-AzResourceGroupDeployment -ResourceGroupName [sandbox resource group name] | Format-Table
            ```

            ```Azure CLI
            az deployment group list --output table
            ```

    4. Add an App Service plan and app to your Bicep template
        - In this task, you'll add an App Service plan and app to the Bicep template.

        1. In the **main.bicep** file in Visual Studio Code, add the following code to the bottom of the file:
            ```Bicep
            resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
              name: 'toy-product-launch-plan-starter'
              location: 'eastus'
              sku: {
                name: 'F1'
              }
            }

            resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
              name: 'toy-product-launch-1'
              location: 'eastus'
              properties: {
                serverFarmId: appServicePlan.id
                httpsOnly: true
              }
            }
            ```

        2. Update the name of the App Service app from **toy-product-launch-1** to something that's likely to be unique.
          - Make sure the name is 2 to 60 characters with uppercase and lowercase letters, numbers, and hyphens, and doesn't start or end with a hyphen.

    5. Deploy the updated Bicep template
        ```Azure PS
        New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep
        ```

        ```Azure CLI
        az deployment group create --name main --template-file main.bicep
        ```

    6. Check your deployment
        1. Return to the Azure portal and go to your resource group.
            - You'll still see one successful deployment, because the deployment used the same name as the first deployment.
        2. Select the **1 Succeeded** link.
        3. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources
        4. Notice that the App Service plan and app were deployed

5. Add flexibility by using parameters and variables
    - Templates are powerful because of their reusability. 
      + You can use Bicep to write templates that deploy multiple environments or copies of your resources.

    - Your toy company launches new products regularly, and you need to use the Bicep templates to create the Azure resources required for each product launch.
      + You need to avoid using fixed resource names.
      + Many types of Azure resources need unique names, so embedding names in your template means you can't reuse the template for multiple product launches.
      + You also have to deploy the resources in different locations depending on where the toys will be launched, which means you can't embed the resource locations in your template either.


    1. Parameters and variables
        - A parameter lets you bring in values from outside the template file.
          + For example, if you're manually deploying the template by using the Azure CLI or Azure PowerShell, you'll be asked to provide values for each parameter.
          + You can also create a parameter file, which lists all of the parameters and values you want to use for the deployment.
          + If the template is deployed from an automated process like a deployment pipeline, the pipeline can provide the parameter values.

        - A variable is defined and set within the template.
          + Variables let you store important information in one place and refer to it throughout the template without having to copy and paste it.

        - It's usually a good idea to use parameters for things that will change between each deployment, like:
          + Resource names that need to be unique.
          + Locations into which to deploy the resources.
          + Settings that affect the pricing of resources, like their SKUs, pricing tiers, and instance counts.
          + Credentials and information needed to access other systems that aren't defined in the template.

        - Variables are usually a good option when you'll use the same values for each deployment,
          + but you want to make a value reusable within the template, or when you want to use expressions to create a complex value. 
          + You can also use variables for resources that don't need unique names.

        - TIP: It's important to use good naming for parameters and variables, so your templates are easy to read and understand. 
          + Make sure you're using clear, descriptive, and consistent names.

    2. Add a parameter
        ```Bicep
        param appServiceAppName string
        ```
        - **param** tells Bicep that you're defining a parameter.
        - **appServiceAppName** is the name of the parameter.
        - **string** is the type of the parameter.
          + **string** for text
          + **int** for numbers
          + **bool** for Boolean true or false values
          + complex parameters: **array** and **object** types

        - TIP: Try not to over-generalize templates by using too many parameters.
          + You should use the minimum number of parameters you need for your business scenario.
          + Remember, you can always change templates in the future if your requirements change.


        1. Provide default values
            ```Bicep
            param appServiceAppName string = 'toy-product-launch-1'
            ```
            - NOTE: the Azure App Service app name has a hard-coded default value. This isn't a good idea, because App Service apps need unique names. 

        2. Use parameter values in the template
            ```Bicep
            resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
              name: appServiceAppName
              location: 'eastus'
              properties: {
                serverFarmId: appServicePlan.id
                httpsOnly: true
              }
            }
            ```

    3. Add a variable
        ```Bicep
        var appServicePlanName = 'toy-product-launch-plan'
        ```
        - Use the **var** keyword to tell Bicep you're declaring a variable
        - You must provide a value for a variable
        - Variables don't need types. Bicep can determine the type based on the value that you set.

    4. Expressions
        - When you're writing templates, you often don't want to hard-code values, or even ask for them to be specified in a parameter.
          + Instead, you want to discover values when the template runs. 
          + For example,
            - you probably want to deploy all of the resources in a template into a single Azure region: the region where you've created the resource group.
            - Or, you might want to automatically create a unique name for a resource based on a particular naming strategy your company uses.

        - Expressions in Bicep are a powerful feature that helps you handle all sorts of interesting scenarios.
        - Let's take a look at a few places where you can use expressions in a Bicep template.
          1. Resource locations
              - you might have a simple business rule that says, **by default, deploy all resources into the same location in which the resource group was created**.

                ```Bicep
                param location string = resourceGroup().location
                ```
                + It uses a *function* called **resourceGroup()** that gives you access to information about the resource group into which the template is being deployed.
                  - In this example, the template uses the **location** property.

              - NOTE: Some resources in Azure can be deployed only into certain locations. 
                + You might need separate parameters to set the locations of these resources.

              - use the resource location parameter inside the template:
                ```Bicep
                resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
                  name: appServiceAppName
                  location: location
                  properties: {
                    serverFarmId: appServicePlan.id
                    httpsOnly: true
                  }
                }
                ```

          2. Resource names
              - Many Azure resources need unique names.
                + In your scenario, you have two resources that need unique names: the storage account and the App Service app.
                + Asking for these values to be set as parameters can make it difficult for whoever uses the template, because they need to find a name that nobody else has used.

              - Bicep has another function called **uniqueString()** that comes in handy when you're creating resource names.
                + When you use this function, you need to provide a **seed value**, which should be different across different deployments, but consistent across all deployments for the same resources.

              - If you choose a good seed value, you can get the same name every time you deploy the same set of resources, but you'll get a different name whenever you deploy a different set of resources by using the same template.

              - Let's look at how you might use the **uniqueString()** function:
                ```Bicep
                param storageAccountName string = uniqueString(resourceGroup().id)

                  --> Resource group ID: /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/MyResourceGroup
                ```

              - The resource group ID is often a good candidate for a seed value for resource names, because:
                + Every time you deploy the same resources, they'll go into the same resource group. 
                  - The **uniqueString()** function will return the same value every time.

                + If you deploy into two different resource groups in the Azure subscription, the **resourceGroup().id** value will be different, because the resource group names will be different.
                  - The **uniqueString()** function will give different values for each set of resources.

                + If you deploy into two different Azure subscriptions, *even if you use the same resource group name*, the **resourceGroup().id** value will be different because the Azure subscription ID will be different. 
                  - The **uniqueString()** function will again give different values for each set of resources.

              - TIP: It's often a good idea to use template expressions to create resource names. 
                + Many Azure resource types have rules about the allowed characters and length of their names.
                + Embedding the creation of resource names in the template means that anyone who uses the template doesn't have to remember to follow these rules themselves.

          3. Combined strings
              - If you just use the **uniqueString()** function to set resource names, you'll probably get unique names, but they won't be meaningful. 
                + A good resource name should also be descriptive, so that it's clear what the resource is for. 
                + You'll often want to create a name by combining a meaningful word or string with a unique value. 
                + This way, you'll have resources that have both meaningful and unique names.

              - Bicep has a feature called string interpolation that lets you combine strings.
              - Let's see how it works:
                ```Bicep
                param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
                ```
                + The default value for the **storageAccountName** parameter now has two parts to it:
                  - **toylaunch** is a hard-coded string that helps anyone who looks at the deployed resource in Azure to understand the storage account's purpose.
                  - **${uniqueString(resourceGroup().id)}** is a way of telling Bicep to evaluate the output of the **uniqueString(resourceGroup().id)** function, then concatenate it into the string.

                + TIP: Sometimes the **uniqueString()** function will create strings that start with a number. 
                  - Some Azure resources, like storage accounts, don't allow their names to start with numbers.
                  - This means it's a good idea to use string interpolation to create resource names, like in the preceding example.

          4. Selecting SKUs for resources
              - One of your colleagues has suggested that you create non-production environments for each product launch to help the marketing team test the sites before they're available to customers.
              - However, you want to make sure you don't spend too much money on your non-production environments, so you decide on some policies together:
                + In production environments, storage accounts will be deployed at the **Standard_GRS** (geo-redundant storage) SKU for high resiliency.
                  - App Service plans will be deployed at the **P2v3** SKU for high performance.

                + In non-production environments, storage accounts will be deployed at the **Standard_LRS** (locally redundant storage) SKU.
                  - App Service plans will be deployed at the free **F1** SKU.

              - One way to implement these business requirements is to use parameters to specify each SKU. 
                + However, specifying every SKU as a parameter can become difficult to manage, especially when you have larger templates. 
                + Another option is to embed the business rules into the template by using **a combination of parameters, variables, and expressions**.

              - First, you can specify a parameter that indicates whether the deployment is for a production or non-production environment:
                ```Bicep
                @allowed([
                  'nonprod'
                  'prod'
                ])
                param environmentType string
                ```
                + Notice that this code uses some new syntax to specify a list of **allowed values** for the **environmentType** parameter. 
                  - Bicep won't let anyone deploy the template unless they provide one of these values.

              - Next, you can create variables that determine the SKUs to use for the storage account and App Service plan based on the environment:
                ```Bicep
                var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
                var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'
                ```
                + **(environmentType == 'prod')** evaluates to a Boolean (true or false) value.
                + **?** is called a ternary operator, and it evaluates an if/then statement

              - TIP: When you create multipart expressions like this, it's best to use variables rather than embedding the expressions directly into the resource properties.
                + This makes your templates easier to read and understand, because it avoids cluttering your resource definitions with logic.

6. Exercise - Add parameters and variables to your Bicep template
    1. Add the location and resource name parameters
        1. In the **main.bicep** file in Visual Studio Code, add the following code to the top of the file:
            ```Bicep
            param location string = 'eastus'
            param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
            param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

            var appServicePlanName = 'toy-product-launch-plan'
            ```

        2. Find the places within the resource definitions where the location and name properties are set, and update them to use the parameter values
            ```Bicep
            resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
              name: storageAccountName
              location: location
              sku: {
                name: 'Standard_LRS'
              }
              kind: 'StorageV2'
              properties: {
                accessTier: 'Hot'
              }
            }

            resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
              name: appServicePlanName
              location: location
              sku: {
                name: 'F1'
              }
            }

            resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
              name: appServiceAppName
              location: location
              properties: {
                serverFarmId: appServicePlan.id
                httpsOnly: true
              }
            }
            ```

    2. Automatically set the SKUs for each environment type
        1. In the **main.bicep** file in Visual Studio Code, add the following Bicep parameter below the parameters that you created in the previous task:
            ```Bicep
            @allowed([
              'nonprod'
              'prod'
            ])
            param environmentType string
            ```

        2. Below the line that declares the **appServicePlanName** variable, add the following variable definitions:
            ```Bicep
            var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
            var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'
            ```

        3. Find the places within the resource definitions where the **sku** properties are set and update them to use the parameter values
            ```Bicep
            resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
              name: storageAccountName
              location: location
              sku: {
                name: storageAccountSkuName
              }
              kind: 'StorageV2'
              properties: {
                accessTier: 'Hot'
              }
            }

            resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
              name: appServicePlanName
              location: location
              sku: {
                name: appServicePlanSkuName
              }
            }

            resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
              name: appServiceAppName
              location: location
              properties: {
                serverFarmId: appServicePlan.id
                httpsOnly: true
              }
            }
            ```


    3. Verify your Bicep file
        - After you've completed all of the preceding changes, your main.bicep file should look like this example:
          ```Bicep
          param location string = 'eastus'
          param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
          param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

          @allowed([
            'nonprod'
            'prod'
          ])
          param environmentType string

          var appServicePlanName = 'toy-product-launch-plan'
          var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
          var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
            name: storageAccountName
            location: location
            sku: {
              name: storageAccountSkuName
            }
            kind: 'StorageV2'
            properties: {
              accessTier: 'Hot'
            }
          }

          resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
            name: appServicePlanName
            location: location
            sku: {
              name: appServicePlanSkuName
            }
          }

          resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
            name: appServiceAppName
            location: location
            properties: {
              serverFarmId: appServicePlan.id
              httpsOnly: true
            }
          }
          ```

        1. Deploy the updated Bicep template
            ```Azure CLI
            az deployment group create --name main --template-file main.bicep --parameters environmentType=nonprod -g rg-mslearn
            ```
            - Notice that you're explicitly specifying the value for the **environmentType** parameter when you execute the deployment.
            - You don't need to specify the other parameter values, because they have valid default values.

        2. Check your deployment
            1. go back to the Azure portal and go to your resource group. You'll still see one successful deployment.
            2. Select the 1 Succeeded link.
            3. Select the deployment called **main**, and then select **Deployment** details.
            4. Notice that a new App Service app and storage account have been deployed with randomly generated names.

7. Group related resources by using modules
    - The IT manager can see your Bicep code is becoming more complex and has an increasing number of resources defined, so they've asked if you can make the code more **modularized**. 
      + You can create individual Bicep files, called modules, for different parts of your deployment. 
      + The main Bicep template can reference these modules. 
      + Behind the scenes, modules are transpiled into a single JSON template for deployment.

    - You'll also often need to emit outputs from the Bicep modules and templates. 
      + Outputs are a way for your Bicep code to send data back to whoever or whatever started the deployment

    1. Outputs
        - Here are some example scenarios where you might need to get information from the template deployment:
          + You create a Bicep template that deploys a virtual machine, and you need to get the public IP address so you can SSH into the machine.
          + You create a Bicep template that accepts a set of parameters, like an environment name and an application name.
            - You need to output the app's name that the template has deployed so you can use it within a deployment pipeline to publish the application binaries.

        - To define an output in a Bicep template, use the **output** keyword like this:
          ```Bicep
          output appServiceAppName string = appServiceAppName
          ```
          + The **output** keyword tells Bicep you're defining an output
          + appServiceAppName is the output's name.
          + A value must be specified for each output. Unlike parameters, outputs always need to have values.
            - Output values can be expressions, references to parameters or variables, or properties of resources that are deployed within the file.

        - TIP: Outputs can use the same names as variables and parameters.
          + This convention can be helpful if you construct a complex expression within a variable to use within your template's resources,
            - and you also need to expose the variable's value as an output.

        - Another example, This one will have its value set to the fully qualified domain name (FQDN) of a public IP address resource.
            ```Bicep
            output ipFqdn string = publicIPAddress.properties.dnsSettings.fqdn
            ```

        - TIP: Try to use resource properties as outputs rather than making assumptions about how resources will behave. 
          + For example, if you need to have an output for App Service app's URL, use the app's **defaultHostName** property instead of creating a string for the URL yourself.
          + Sometimes these assumptions aren't valid in different environments, or the way the resource works changes, so it's safer to have the resource tell you its own properties.

        - CAUTION: Don't create outputs for secret values like connection strings or keys. Anyone with access to your resource group can read outputs from templates.

    2. Define a module
        - Bicep modules allow you to organize and reuse your Bicep code by creating smaller units that can be composed into a template. 
          + Any Bicep template can be used as a module by another template.

        - Imagine you have a Bicep template that deploys application, database, and networking resources for **solution A**.
          + You might split this template into three modules, each of which is focused on its own set of resources. 
          + As a bonus, you can now reuse the modules in other templates for other solutions too; 
          + so when you develop a template for **solution B**, which has similar networking requirements to **solution A**, you can reuse the network module.

        - When you want the template to include a reference to a module file, use the **module** keyword.
        - A module definition looks similar to a resource declaration, but instead of including a resource type and API version, you'll use the module's file name:
          ```Bicep
          module myModule 'modules/mymodule.bicep' = {
            name: 'MyModule'
            params: {
              location: location
            }
          }
          ```
          + **modules/mymodule.bicep** is the path to the module file, relative to the template file.
            - Remember, a module file is just a regular Bicep file.
          + **name** property is mandatory.
            - Azure uses the module name because it creates a separate deployment for each module within the template file.
            - Those deployments have names you can use to identify them.
          + You can specify any parameters of the module by using the **params** keyword.
            - When you set the values of each parameter within the template, you can use expressions, template parameters, variables, properties of resources deployed within the template, and outputs from other modules. 
            - Bicep will automatically understand the dependencies between the resources.

    3. Modules and outputs
        - Just like templates, Bicep modules can define outputs.
        - It's common to chain modules together within a template. 
        - In that case, the output from one module can be a parameter for another module. 
        - By using modules and outputs together, you can create powerful and reusable Bicep files.

    4. Design your modules
        - A good Bicep module follows some key principles:
          + 1. A module should have a clear purpose.
            - You can use modules to define all of the resources related to a specific part of your solution. 
            - For example, you might create a module that contains all of the resources used to monitor your application. 
            - You might also use a module to define a set of resources that belong together, like all of your database servers and databases.

          + 2. Don't put every resource into its own module
            - You shouldn't create a separate module for every resource you deploy. 
            - If you have a resource that has many complex properties,
              + it might make sense to put that resource into its own module, 
              + but in general, it's better for modules to combine multiple resources.


          + 3. A module should have clear parameters and outputs that make sense.
            - Consider the purpose of the module.
            - Think about whether the module should manipulate parameter values, 
              + or whether the parent template should handle that, 
              + and then pass a single value through to the module.

            - Similarly, think about the outputs a module should return, 
              + and make sure they're useful to the templates that will use the module.

          + 4. A module should be as self-contained as possible.
            - If a module needs to use a variable to define a part of a module, 
              + the variable should generally be included in the module file rather than in the parent template.

          + 5. A module shouldn't output secrets.
            - Just like templates, don't create module outputs for secret values like connection strings or keys.

8. Exercise - Refactor your template to use modules
    - During the process, you'll:
      + Add a new module and move the App Service resources into it.
      + Reference the module from the main Bicep template.
      + Add an output for the App Service app's host name, and emit it from the module and template deployments.
      + Test the deployment to ensure that the template is valid.

    1. Add a new module file
        1. In Visual Studio Code, create a new folder called **modules** in the same folder where you created your **main.bicep** file. 
            - In the **modules** folder, create a file called **appService.bicep**
              ```Bicep
              param location string
              param appServiceAppName string

              @allowed([
                'nonprod'
                'prod'
              ])
              param environmentType string

              var appServicePlanName = 'toy-product-launch-plan'
              var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

              resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
                name: appServicePlanName
                location: location
                sku: {
                  name: appServicePlanSkuName
                }
              }

              resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
                name: appServiceAppName
                location: location
                properties: {
                  serverFarmId: appServicePlan.id
                  httpsOnly: true
                }
              }
              ```

        2. Add a reference to the module from the parent template
            1. In the **main.bicep** file, delete the App Service resources and the **appServicePlanName** and **appServicePlanSkuName** variable definitions. 
                - Don't delete the App Service parameters, because you still need them.
                - Also, don't delete the storage account parameters, variable, or resources.

            2. At the bottom of the main.bicep file, add the following Bicep code:
                ```Bicep
                module appService 'modules/appService.bicep' = {
                  name: 'appService'
                  params: {
                    location: location
                    appServiceAppName: appServiceAppName
                    environmentType: environmentType
                  }
                }
                ```

    2. Add the host name as an output
        1. Add the following Bicep code at the bottom of the **appService.bicep** file:
            ```Bicep
            output appServiceAppHostName string = appServiceApp.properties.defaultHostName
            ```
            - You also need to return the output to the person who deployed the template.

        2. Open the **main.bicep** file and add the following code at the bottom of the file:
            ```Bicep
            output appServiceAppHostName string = appService.outputs.appServiceAppHostName
            ```
            - Notice that this output is declared in a similar way to the output in the module.
            - But this time, you're referencing the module's output instead of a resource property.

    3. Verify your Bicep files
        - **main.bicep** file should look like: 
          ```Bicep
          param location string = 'eastus'
          param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
          param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

          @allowed([
            'nonprod'
            'prod'
          ])
          param environmentType string

          var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
            name: storageAccountName
            location: location
            sku: {
              name: storageAccountSkuName
            }
            kind: 'StorageV2'
            properties: {
              accessTier: 'Hot'
            }
          }

          module appService 'modules/appService.bicep' = {
            name: 'appService'
            params: {
              location: location
              appServiceAppName: appServiceAppName
              environmentType: environmentType
            }
          }

          output appServiceAppHostName string = appService.outputs.appServiceAppHostName
          ```

        - appService.bicep file should look like:
          ```Bicep
          param location string
          param appServiceAppName string

          @allowed([
            'nonprod'
            'prod'
          ])
          param environmentType string

          var appServicePlanName = 'toy-product-launch-plan'
          var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

          resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
            name: appServicePlanName
            location: location
            sku: {
              name: appServicePlanSkuName
            }
          }

          resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
            name: appServiceAppName
            location: location
            properties: {
              serverFarmId: appServicePlan.id
              httpsOnly: true
            }
          }

          output appServiceAppHostName string = appServiceApp.properties.defaultHostName
          ```

        1. Deploy the updated Bicep template
            ```Azure CLI
            az deployment group create --name main --template-file main.bicep --parameters environmentType=nonprod -g rg-mslearn
            ```

        2. Check your deployment
            1. go back to the Azure portal. Go to your resource group; there are now two successful deployments.
            2. Select the **2 Succeeded** link: **main** and **appService**
            3. Select the **Outputs** tab. 
                - Notice that there's an output called **appServiceAppHostName** with the host name of your App Service app.

9. Summary
- You created a Bicep template to deploy a basic storage account, an Azure App Service plan, and an application. 
  + You parameterized the template to make it useful for future products. 
  + You then refactored it into modules to make the template more reusable, and easier to understand and work with.
  + Finally, you added an output to send information from a template deployment back to the person or tool executing the deployment.

- References:
    + Bicep documentation: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep
    + Template reference for each Azure resource type: https://learn.microsoft.com/en-us/azure/templates/
    + Bicep functions: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions