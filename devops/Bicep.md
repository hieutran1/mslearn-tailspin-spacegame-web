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

# Part 1: Fundamentals of Bicep
- https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

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
- https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

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
              location: 'eastasia'
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
            location: 'eastasia'
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
            location: 'eastasia'
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

## Build reusable Bicep templates by using parameters
- https://learn.microsoft.com/en-us/training/modules/build-reusable-bicep-templates-parameters

1. Example scenario
    - Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. 
      + The human resources (HR) department is migrating an on-premises web application and its database to Azure. 
      + The application will handle information about all of the toy company employees, so security is important.

    - You've been asked to prepare infrastructure for three environments: dev, test, and production. 
      + You'll build this infrastructure by using infrastructure as code techniques so that you can reuse the same templates to deploy across all of your environments. 
      + You'll create separate sets of parameter values for each environment, while securely retrieving database credentials from Azure Key Vault.

2. Understand parameters
    1. Declare a parameter
        ```Bicep
        param environmentName string
        ```
    2. Add a default value
        ```Bicep
        Add a default value
        ```

    3. Understand parameter types
        - Parameters in Bicep can be one of the following types:
          + **string**, which lets you enter arbitrary text.
          + **int**, which lets you enter a number.
          + **bool**, which represents a Boolean (true or false) value.
          + **object** and **array**, which represent structured data and lists.

        1. Objects
            ```
            param appServicePlanSku object = {
              name: 'F1'
              tier: 'Free'
              capacity: 1
            }
            ```

            - Usage:
              ```Bicep
              resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
                name: appServicePlanName
                location: location
                sku: {
                  name: appServicePlanSku.name
                  tier: appServicePlanSku.tier
                  capacity: appServicePlanSku.capacity
                }
              }
              ```

            - Another example of where you might use an object parameter is for specifying resource tags.
              + You can attach custom tag metadata to the resources that you deploy, which you can use to identify important information about a resource.
              + Tags are useful for scenarios like tracking which team owns a resource, or when a resource belongs to a production or non-production environment.

              ```Bicep
              param resourceTags object = {
                EnvironmentName: 'Test'
                CostCenter: '1000100'
                Team: 'Human Resources'
              }
              ```
              - Whenever you define a resource in your Bicep file, you can reuse it wherever you define the tags property:
                ```Bicep
                resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
                  name: appServicePlanName
                  location: location
                  tags: resourceTags // NOTICE
                  sku: {
                    name: 'S1'
                  }
                }

                resource appServiceApp 'Microsoft.Web/sites@' = {
                  name: appServiceAppName
                  location: location
                  tags: resourceTags // NOTICE
                  kind: 'app'
                  properties: {
                    serverFarmId: appServicePlan.id
                  }
                }
                ```

        2. Arrays
            - An array is a list of items. 
            - As an example, you might use an array of string values to declare a list of email addresses for an Azure Monitor action group.
              + Or you might use an array of objects to represent a list of subnets for a virtual network.

            ```Bicep
            param cosmosDBAccountLocations array = [
              {
                locationName: 'australiaeast'
              }
              {
                locationName: 'southcentralus'
              }
              {
                locationName: 'westeurope'
              }
            ]
            ```

    4. Specify a list of allowed values
        ```Bicep
        @allowed([
          'P1v3'
          'P2v3'
          'P3v3'
        ])
        param appServicePlanSkuName string
        ```

    5. Restrict parameter length and values
        ```Bicep
        @minLength(5)
        @maxLength(24)
        param storageAccountName string
        ```

        ```
        @minValue(1)
        @maxValue(10)
        param appServicePlanInstanceCount int
        ```
    
    6. Add descriptions to parameters
        ```Bicep
        @description('The locations into which this Cosmos DB account should be configured. This parameter needs to be a list of objects, each of which has a locationName property.')
        param cosmosDBAccountLocations array
        ```

3. Exercise - Add parameters and decorators
    1. Create a Bicep template with parameters
        - Create **main.bicep** file:
            ```Bicep
            param environmentName string = 'dev'
            param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'
            param appServicePlanInstanceCount int = 1
            param appServicePlanSku object = {
              name: 'F1'
              tier: 'Free'
            }
            param location string = 'eastus'

            var appServicePlanName = '${environmentName}-${solutionName}-plan'
            var appServiceAppName = '${environmentName}-${solutionName}-app'
            ```
            + TIP:
              - The **uniqueString()** function is useful for creating globally unique resource names.
                + It returns a string that's the same on every deployment to the same resource group, but different when you deploy to different resource groups or subscriptions.

              - You're specifying that the **location** parameter should be set to **westus3**. 
                + Normally, you would create resources in the same location as the resource group by using the **resourceGroup().location** property. 
                + But when you work with the Microsoft Learn sandbox, you need to use certain Azure regions that don't match the resource group's location.

        - In the **main.bicep** file in Visual Studio Code, add the following code to the bottom of the file:
            ```Bicep
            resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
              name: appServicePlanName
              location: location
              sku: {
                name: appServicePlanSku.name
                tier: appServicePlanSku.tier
                capacity: appServicePlanInstanceCount
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

        1. Add parameter descriptions
            - In the **main.bicep** file in Visual Studio Code, add the **@description** decorator directly above every parameter
              ```Bicep
              @description('The name of the environment. This must be dev, test, or prod.')
              param environmentName string = 'dev'

              @description('The unique name of the solution. This is used to ensure that resource names are unique.')
              param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

              @description('The number of App Service plan instances.')
              param appServicePlanInstanceCount int = 1

              @description('The name and tier of the App Service plan SKU.')
              param appServicePlanSku object = {
                name: 'F1'
                tier: 'Free'
              }

              @description('The Azure region into which the resources should be deployed.')
              param location string = 'eastus'
              ```

        2. Limit input values
            - Your toy company will deploy the HR application to three environments: *dev*, *test*, and *prod*.
              + You'll limit the *environmentName* parameter to only allow those three values.

            - In the **main.bicep** file in Visual Studio Code, find the **environmentName** parameter. 
              + Insert an **@allowed** decorator underneath its **@description** decorator
                ```Bicep
                @description('The name of the environment. This must be dev, test, or prod.')
                @allowed([
                  'dev'
                  'test'
                  'prod'
                ])
                param environmentName string = 'dev'
                ```

        3. Limit input lengths
            - Your **solutionName** parameter is used to generate the names of resources. 
              + You want to enforce a minimum length of 5 characters and a maximum length of 30 characters.
                ```
                @description('The unique name of the solution. This is used to ensure that resource names are unique.')
                @minLength(5)
                @maxLength(30)
                param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'
                ```

        4. Limit numeric values
            - Next, you'll ensure that the **appServicePlanInstanceCount** parameter only allows values between 1 and 10.
              ```Bicep
              @description('The number of App Service plan instances.')
              @minValue(1)
              @maxValue(10)
              param appServicePlanInstanceCount int = 1
              ```

    2. Verify your Bicep file
        - **main.bicep** file completed:
          ```Bicep
          @description('The name of the environment. This must be dev, test, or prod.')
          @allowed([
            'dev'
            'test'
            'prod'
          ])
          param environmentName string = 'dev'

          @description('The unique name of the solution. This is used to ensure that resource names are unique.')
          @minLength(5)
          @maxLength(30)
          param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

          @description('The number of App Service plan instances.')
          @minValue(1)
          @maxValue(10)
          param appServicePlanInstanceCount int = 1

          @description('The name and tier of the App Service plan SKU.')
          param appServicePlanSku object = {
            name: 'F1'
            tier: 'Free'
          }

          @description('The Azure region into which the resources should be deployed.')
          param location string = 'eastus'

          var appServicePlanName = '${environmentName}-${solutionName}-plan'
          var appServiceAppName = '${environmentName}-${solutionName}-app'

          resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
            name: appServicePlanName
            location: location
            sku: {
              name: appServicePlanSku.name
              tier: appServicePlanSku.tier
              capacity: appServicePlanInstanceCount
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

    3. Deploy the Bicep template to Azure
        1. Install Bicep
            - Run the following command to ensure you have the latest version of Bicep:
              ```Azure CLI
              az bicep install && az bicep upgrade
              ```

            - To use Bicep from Azure PowerShell, install the Bicep CLI
              + https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#azure-powershell

        2. Sign in to Azure
            1. In the Visual Studio Code terminal, sign in to Azure by running the following command:
                ```Azure CLI
                az login
                ```
                ```Azure PS
                Connect-AzAccount
                ```

            2. Get the Concierge Subscription IDs
                ```Azure CLI
                az account list --refresh --query "[?contains(name, 'Concierge Subscription')].id" --output table
                ```
                ```Azure PS
                Get-AzSubscription
                ```

            3. Set the default subscription by using the subscription ID
                ```Azure CLI
                az account set --subscription {your subscription ID}
                ```

                ```Azure PS
                $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
                Set-AzContext $context
                ```

        3. Set the default resource group
            ```Azure CLI
            az group create --name rg-mslearn --location eastasia

            az configure --defaults group="[sandbox resource group name]"
            ```
            - When you use the Azure CLI, you can set the default resource group and omit the parameter from the rest of the Azure CLI commands.

            ```Azure PS
            Set-AzDefault -ResourceGroupName [sandbox resource group name]
            ```

        4. Deploy the template to Azure by using the Azure CLI
            ```Azure CLI
            az deployment group create --name main --template-file main.bicep
            ```

            ```Azure PS
            New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep
            ```

    4. Verify your deployment 
        - Go to Resource groups of the Azure portal, check deployment called **main**.

4. Provide values using parameter files
    1. Create parameters files
        - Parameters files make it easy to specify parameter values together as a set.
        - parameters files are created by using a Bicep parameters file with the **.bicepparam** file extension or a JSON parameters file.
        - Here's what a JSON parameters file looks like:
          ```JSON
          {
            "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
              "appServicePlanInstanceCount": {
                "value": 3
              },
              "appServicePlanSku": {
                "value": {
                  "name": "P1v3",
                  "tier": "PremiumV3"
                }
              },
              "cosmosDBAccountLocations": {
                "value": [
                  {
                    "locationName": "australiaeast"
                  },
                  {
                    "locationName": "southcentralus"
                  },
                  {
                    "locationName": "westeurope"
                  }
                ]
              }
            }
          }
          ```
          + **$schema** helps Azure Resource Manager to understand that this file is a parameters file.
          + **contentVersion** is a property that you can use to keep track of significant changes in your parameters file if you want.
            - Usually, it's set to its default value of **1.0.0.0**.
          + The **parameters** section lists each parameter and the value you want to use. The parameter value must be specified as an object. 
            - The object has a property called **value** that defines the actual parameter value to use.

        - Generally, you'll create a parameters file for each environment.
          + It's a good practice to include the environment name in the name of the parameters file.
        - For example, **main.parameters.dev.json** for your development environment and **main.parameters.production.json** for your production environment.

        - NOTE: Make sure you only specify values for parameters that exist in your Bicep template. 
          + When you create a deployment, Azure checks your parameters and gives you an error if you've tried to specify a value for a parameter that isn't in the Bicep file.

    2. Use parameters files at deployment time
        - **az deployment group create** command, **--parameters** argument
          ```Azure CLI
          az deployment group create --name main --template-file main.bicep --parameters main.parameters.json
          ```

    3. Override parameter values
        - Three ways to specify parameter values: *default values*, *the command line*, and *parameters files*.
        - Order of precedence: *default values* --> *parameters files* --> *the command line*

        - Let's see how this approach works.
          + Here's an example Bicep file that defines three parameters, each with default values:
            ```Bicep
            param location string = resourceGroup().location
            param appServicePlanInstanceCount int = 1
            param appServicePlanSku object = {
              name: 'F1'
              tier: 'Free'
            }
            ```

          + Let's look at a parameters file that overrides the value of two of the parameters but doesn't specify a value for the **location** parameter:
            ```JSON
            {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "appServicePlanInstanceCount": {
                  "value": 3
                },
                "appServicePlanSku": {
                  "value": {
                    "name": "P1v3",
                    "tier": "PremiumV3"
                  }
                }
              }
            }
            ```

          + When you create the deployment, we also override the value for **appServicePlanInstanceCount**.
            - Like with parameters files, you use the **--parameters** argument, but you add the value you want to override as its own value:
              ```
              az deployment group create --name main --template-file main.bicep --parameters main.parameters.json appServicePlanInstanceCount=5
              ```

5. Secure your parameters
    - Sometimes you need to pass sensitive values into your deployments, like passwords and API keys. 
      + But you need to ensure these values are protected. 
      + In some situations, you don't want the person who's creating the deployment to know the secret values. 
      + Other times, someone will enter the parameter value when they create the deployment, but you need to make sure the secret values aren't logged.

    1. Define secure parameters
        - The **@secure** decorator can be applied to string and object parameters that might contain secret values.
        - As part of the HR application migration, you need to deploy an Azure SQL logical server and database.
          + You'll provision the logical server with an administrator login and password
            ```
            @secure()
            param sqlServerAdministratorLogin string

            @secure()
            param sqlServerAdministratorPassword string
            ```
            - NOTICE: that neither parameter has a default value specified. 
              + It's a good practice to avoid specifying default values for usernames, passwords, and other secrets

            - TIP: Make sure you don't create outputs for sensitive data. 
              + Output values can be accessed by anyone who has access to the deployment history. 
              + They're not appropriate for handling secrets.

      2. Avoid using parameters files for secrets

      3. Integrate with Azure Key Vault
          - Azure Key Vault is a service designed to store and provide access to secrets.
            + You can integrate your Bicep templates with Key Vault by using a parameters file with a reference to a Key Vault secret.

          - TIP: You can refer to secrets in key vaults that are located in a different resource group or subscription from the one you're deploying to.

          - Here's a parameters file that uses Key Vault references to look up the SQL logical server administrator login and password to use: *sqlServerAdministratorLogin* and *sqlServerAdministratorPassword* block
            ```JSON
            {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "sqlServerAdministratorLogin": {
                  "reference": {
                    "keyVault": {
                      "id": "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toysecrets"
                    },
                    "secretName": "sqlAdminLogin"
                  }
                },
                "sqlServerAdministratorPassword": {
                  "reference": {
                    "keyVault": {
                      "id": "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toysecrets"
                    },
                    "secretName": "sqlAdminLoginPassword"
                  }
                }
              }
            }
            ```
            + NOTICE: that instead of specifying a value for each of the parameters, this file has a reference object, which contains details of the key vault and secret.

            + IMPORTANT: Your key vault must be configured to allow Resource Manager to access the data in the key vault during template deployments.
              - Also, the user who deploys the template must have permission to access the key vault.

      4. Use Key Vault with modules
          - Here's an example Bicep file that deploys a module and provides the value of the **ApiKey** secret parameter by taking it directly from Key Vault:
            ```Bicep
            resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
              name: keyVaultName
            }

            module applicationModule 'application.bicep' = {
              name: 'application-module'
              params: {
                apiKey: keyVault.getSecret('ApiKey') // Update
              }
            }
            ```
            + NOTICE: the Key Vault resource is referenced by using the **existing** keyword.
              - The keyword tells Bicep that the Key Vault already exists, and this code is a reference to that vault. 
                + Bicep won't redeploy it
            + NOTICE:the module's code uses the **getSecret()** function in the value for the module's **apiKey** parameter
              - This is a special Bicep function that can only be used with secure module parameters.
              - Internally, Bicep translates this expression to the same kind of Key Vault reference you learned about earlier.

6. Exercise - Add a parameter file and secure parameters
    1. Update existing **main.bicep** file:
        1. Remove the default value for the App Service plan SKU
            ```Bicep
            @description('The name and tier of the App Service plan SKU.')
            param appServicePlanSku object
            ```

        2. Add new parameters
            - In the main.bicep file in Visual Studio Code, add the **sqlServerAdministratorLogin**, **sqlServerAdministratorPassword**, and **sqlDatabaseSku** parameters underneath the current parameter declarations.
              ```Bicep
              @description('The name of the environment. This must be dev, test, or prod.')
              @allowed([
                'dev'
                'test'
                'prod'
              ])
              param environmentName string = 'dev'

              @description('The unique name of the solution. This is used to ensure that resource names are unique.')
              @minLength(5)
              @maxLength(30)
              param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

              @description('The number of App Service plan instances.')
              @minValue(1)
              @maxValue(10)
              param appServicePlanInstanceCount int = 1

              @description('The name and tier of the App Service plan SKU.')
              param appServicePlanSku object

              @description('The Azure region into which the resources should be deployed.')
              param location string = 'eastus'

              // NEW
              @secure()
              @description('The administrator login username for the SQL server.')
              param sqlServerAdministratorLogin string

              @secure()
              @description('The administrator login password for the SQL server.')
              param sqlServerAdministratorPassword string

              @description('The name and tier of the SQL database SKU.')
              param sqlDatabaseSku object
              ```

        3. Add new variables
            - In the main.bicep file in Visual Studio Code, add the **sqlServerName** and **sqlDatabaseName** variables underneath the existing variables
              ```Bicep
              var appServicePlanName = '${environmentName}-${solutionName}-plan'
              var appServiceAppName = '${environmentName}-${solutionName}-app'
              
              // NEW
              var sqlServerName = '${environmentName}-${solutionName}-sql'
              var sqlDatabaseName = 'Employees'
              ```

        4. Add SQL server and database resources
            - In the **main.bicep** file in Visual Studio Code, add the following code to the bottom of the file:
              ```Bicep
              resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
                name: sqlServerName
                location: location
                properties: {
                  administratorLogin: sqlServerAdministratorLogin
                  administratorLoginPassword: sqlServerAdministratorPassword
                }
              }

              resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
                parent: sqlServer
                name: sqlDatabaseName
                location: location
                sku: {
                  name: sqlDatabaseSku.name
                  tier: sqlDatabaseSku.tier
                }
              }
              ```

    2. Verify your Bicep file
        ```Bicep
        @description('The name of the environment. This must be dev, test, or prod.')
        @allowed([
          'dev'
          'test'
          'prod'
        ])
        param environmentName string = 'dev'

        @description('The unique name of the solution. This is used to ensure that resource names are unique.')
        @minLength(5)
        @maxLength(30)
        param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

        @description('The number of App Service plan instances.')
        @minValue(1)
        @maxValue(10)
        param appServicePlanInstanceCount int = 1

        @description('The name and tier of the App Service plan SKU.')
        param appServicePlanSku object

        @description('The Azure region into which the resources should be deployed.')
        param location string = 'eastus'

        @secure()
        @description('The administrator login username for the SQL server.')
        param sqlServerAdministratorLogin string

        @secure()
        @description('The administrator login password for the SQL server.')
        param sqlServerAdministratorPassword string

        @description('The name and tier of the SQL database SKU.')
        param sqlDatabaseSku object

        var appServicePlanName = '${environmentName}-${solutionName}-plan'
        var appServiceAppName = '${environmentName}-${solutionName}-app'
        var sqlServerName = '${environmentName}-${solutionName}-sql'
        var sqlDatabaseName = 'Employees'

        resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
          name: appServicePlanName
          location: location
          sku: {
            name: appServicePlanSku.name
            tier: appServicePlanSku.tier
            capacity: appServicePlanInstanceCount
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

        resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
          name: sqlServerName
          location: location
          properties: {
            administratorLogin: sqlServerAdministratorLogin
            administratorLoginPassword: sqlServerAdministratorPassword
          }
        }

        resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
          parent: sqlServer
          name: sqlDatabaseName
          location: location
          sku: {
            name: sqlDatabaseSku.name
            tier: sqlDatabaseSku.tier
          }
        }
        ```

    3. Create a parameters file
        - Create **main.parameters.dev.json** file on the folder where the **main.bicep** file located
            ```JSON
            {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "appServicePlanSku": {
                  "value": {
                    "name": "F1",
                    "tier": "Free"
                  }
                },
                "sqlDatabaseSku": {
                  "value": {
                    "name": "Standard",
                    "tier": "Standard"
                  }
                }
              }
            }
            ```

    4. Deploy the Bicep template with the parameters file
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep --parameters main.parameters.dev.json

          --> Login: user
              Password: P@ssword1
        ```
        - NOTE: When you enter the secure parameters, the values you choose must follow some rules:
          + **sqlServerAdministratorLogin** must not be an easily guessable login name like **admin** or **root**. 
            - It can contain only alphanumeric characters and must start with a letter.
          
          + **sqlServerAdministratorPassword** must be at least eight characters long and include lowercase letters, uppercase letters, numbers, and symbols.
            - For more information on password complexity, see the SQL Azure password policy.
              + https://learn.microsoft.com/en-us/sql/relational-databases/security/password-policy#password-complexity

          + If the parameter values don't meet the requirements, Azure SQL won't deploy your server.
          + Also, **make sure you keep a note of the login and password that you enter**.

    5. Create a key vault and secrets
        - Key vault names must be a globally unique string of 3 to 24 characters that can contain only uppercase and lowercase letters, hyphens (-), and numbers.
          + For example, *demo-kv-1234567abcdefg*.

        - To create the **keyVaultName**, **login**, and **password** variables, run each command separately. 
          + Then you can run the block of commands to create the key vault and secrets.
          ```Azure CLI
          keyVaultName='YOUR-KEY-VAULT-NAME'
          keyVaultName=kv-mslearn

          read -s -p "Enter the login name: " login
            --> user

          read -s -p "Enter the password: " password
            --> P@ssword1

          az keyvault create --name $keyVaultName --location eastasia --enabled-for-template-deployment true

          az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login --output none
            --> ISSUE: make sure that you have given **Key Vault Administrator** role to your service principal from **Access Control (IAM)** section of your key vault

          az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password --output none
          ```
          + NOTICE: 
            - You're setting the **--enabled-for-template-deployment** setting on the vault so that Azure can use the secrets from your vault during deployments. 
              + If you don't set this setting then, by default, your deployments can't access secrets in your vault.

            - Also, whoever executes the deployment must also have permission to access the vault. 
              + Because you created the key vault, you're the owner, so you won't have to explicitly grant the permission in this exercise. 
              + For your own vaults, you need to grant access to the secrets.
                - https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/key-vault-parameter#grant-access-to-the-secrets

          + NOTICE: if you cannot create a secret.
            - If you are using **Azure role-based access control (recommended)**, make sure that you have given **Key Vault Administrator** role to your service principal from **Access Control (IAM)** section of your key vault.

        1. Get the key vault's resource ID
            ```Azure CLI
            az keyvault show --name $keyVaultName --query id --output tsv

              --> /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toysecrets
            ```

    6. Add a key vault reference to a parameters file
        - update **main.parameters.dev.json** file, add **sqlServerAdministratorLogin** and **sqlServerAdministratorPassword** blocks
          ```JSON
          {
            "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
              "appServicePlanSku": {
                "value": {
                  "name": "F1",
                  "tier": "Free"
                }
              },
              "sqlDatabaseSku": {
                "value": {
                  "name": "Standard",
                  "tier": "Standard"
                }
              },
              "sqlServerAdministratorLogin": {
                "reference": {
                  "keyVault": {
                    "id": "YOUR-KEY-VAULT-RESOURCE-ID"
                  },
                  "secretName": "sqlServerAdministratorLogin"
                }
              },
              "sqlServerAdministratorPassword": {
                "reference": {
                  "keyVault": {
                    "id": "YOUR-KEY-VAULT-RESOURCE-ID"
                  },
                  "secretName": "sqlServerAdministratorPassword"
                }
              }
            }
          }
          ```

    7. Deploy the Bicep template with parameters file and Azure Key Vault references
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep --parameters main.parameters.dev.json
        ```

        1. Check your deployment
            1. go back to the Azure portal
            2. Notice that the **appServicePlanSku** and the **sqlDatabaseSku** parameter values have both been set to the values in the parameters file.
              - Also, notice that the **sqlServerAdministratorLogin** and **sqlServerAdministratorPassword** parameter values aren't displayed, because you applied the **@secure()** decorator to them.

7. Summary
    - Your company's HR department is migrating an on-premises web application to Azure. 
      + The application will handle information about all of the toy company employees, so security is important.

    - You created a Bicep template to deploy an Azure App Service plan, an application, and an Azure SQL server and database.
      + You parameterized the template to make it generalizable for deploying across multiple environments.
      + You applied parameter decorators to control the allowed parameter values.
      + Finally, you created a parameter file with Azure Key Vault references to keep the administrator login and password secure.

    - Imagine how much work it would be to deploy these resources for each environment.
      + You'd have to manually provision the resources and remember to configure them correctly each time.
      + Manually deploying Azure infrastructure might lead to inconsistency and security risks.

    - Bicep makes it easy to describe your Azure resources and create reusable templates.
      + You can parameterize the templates and use parameter files to automate and secure your deployments.

    - Now, when you want to deploy your infrastructure for other environments, you can use the Bicep template and parameter file that you created.
      + Your company can safely and consistently provision Azure resources.

8. Learn more
    - Bicep parameters: https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-file#parameters
    - Parameters in Bicep: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameters
    - Create Bicep parameter file: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files
    - Azure Key Vault references: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/key-vault-parameter

## Build flexible Bicep templates by using conditions and loops
- https://learn.microsoft.com/en-us/training/modules/build-flexible-bicep-templates-conditions-loops

1. Introduction
    1. Introduction
        - When you work with Bicep templates, conditions and loops can help make your Azure deployments more flexible. 
          + With conditions, you can deploy resources only when specific constraints are in place. 
          + And with loops, you can deploy multiple resources that have similar properties.

    2. Example scenario
        - Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company.
          + Your company is designing a new smart teddy bear toy. 
          + Some of the teddy bear's features are based on back-end server components and SQL databases that are hosted in Azure. 
          + For security reasons, within your production environments, you need to make sure that you've enabled auditing on your Azure SQL logical servers.

        - You expect that the toy will be very popular, and your company plans to launch it in new countries/regions regularly. 
          + Every country/region where you launch the smart teddy bear will need a separate database server and virtual network. 
          + To comply with each country's/region's laws, you'll need to physically place these resources in specific locations.
          + You've been asked to deploy each country's/region's database servers and virtual networks and, at the same time, make it easy to add logical servers and virtual networks as the toy is launched in new countries/regions.

        - Resource Group
          + Azure SQL (logical server, teddy-eastus), Virtual network (teddybear-eastus)
          + Azure SQL (logical server, teddy-westeurope), Virtual network (teddybear-westeurope)
          + Azure SQL (logical server, teddy-eastasia), Virtual network (teddybear-eastasia)

2. Deploy resources conditionally
    - For example, at your toy company, you need to deploy resources to various environments. 
      + When you deploy them to a production environment, you need to ensure that auditing is enabled for your Azure SQL logical servers. 
      + But when you deploy resources to development environments, you don't want to enable auditing.
      + You want to use a single template to deploy resources to all your environments.

    1. Use basic conditions
        - It's common to create conditions based on the values of parameters that you provide.
        - For example, the following code deploys a storage account only when the **deployStorageAccount** parameter is set to **true**:
          ```Bicep
          param deployStorageAccount bool

          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = if (deployStorageAccount) {
            name: 'teddybearstorage'
            location: resourceGroup().location
            kind: 'StorageV2'
            // ...
          }
          ```
          + NOTICE that the **if** keyword is on the same line as the resource definition.

    2. Use expressions as conditions
        - For example, the code deploys a SQL auditing resource only when the **environmentName** parameter value is equal to **Production**:
          ```Bicep
          @allowed([
            'Development'
            'Production'
          ])
          param environmentName string

          resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (environmentName == 'Production') {
            parent: server
            name: 'default'
            properties: {
            }
          }
          ```

        - It's usually a good idea to create a variable for the expression that you're using as a condition.
          + That way, your template is easier to understand and read.
          ```Bicep
          @allowed([
            'Development'
            'Production'
          ])
          param environmentName string

          var auditingEnabled = environmentName == 'Production'

          resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
            parent: server
            name: 'default'
            properties: {
            }
          }
          ```

    3. Depend on conditionally deployed resources
        - When you deploy resources conditionally, you sometimes need to be aware of how Bicep evaluates the dependencies between them.
        - Let's continue writing some Bicep code to deploy SQL auditing settings. 
          + The Bicep file also needs to declare a storage account resource, as shown here: 
          ```Bicep
          @allowed([
            'Development'
            'Production'
          ])
          param environmentName string
          param location string = resourceGroup().location
          param auditStorageAccountName string = 'bearaudit${uniqueString(resourceGroup().id)}'

          var auditingEnabled = environmentName == 'Production'
          var storageAccountSkuName = 'Standard_LRS'

          // Highlight
          resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = if (auditingEnabled) {
            name: auditStorageAccountName
            location: location
            sku: {
              name: storageAccountSkuName
            }
            kind: 'StorageV2'
          }

          resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
            parent: server
            name: 'default'
            properties: {
            }
          }
          ```

        - Notice that the storage account has a condition too. 
          + This means that it won't be deployed for non-production environments either. 
          + The SQL auditing settings resource can now refer to the storage account details:
          ```Bicep
          resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
            parent: server
            name: 'default'
            properties: {
              state: 'Enabled'
              storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
              storageAccountAccessKey: environmentName == 'Production' ? listKeys(auditStorageAccount.id, auditStorageAccount.apiVersion).keys[0].value : ''
            }
          }
          ```
          + IMPOTANT: Azure Resource Manager evaluates the property expressions before the conditionals on the resources.
            - That means that if the Bicep code doesn't have this expression, the deployment will fail with a **ResourceNotFound** error.

        - TIP: If you have several resources, all with the same condition for deployment, consider using Bicep modules.
          + You can create a module that deploys all the resources, then put a condition on the module declaration in your main Bicep file.

3. Exercise - Deploy resources conditionally
    - You need to deploy your toy company's resources to a variety of environments, and you want to use parameters and conditions to control what gets deployed to each environment.

    - In this exercise, you'll create an Azure SQL logical server and a database. 
      + You'll then add auditing settings to ensure that auditing is enabled, but you want it enabled only when you're deploying to a production environment.
      + For auditing purposes, you need to have a storage account, which you'll also deploy only when you're deploying resources to a production environment.

    1. Create a Bicep template with a logical server and database
    2. Add a storage account
    3. Add auditing settings
        ```Bicep
        resource sqlServerAudit 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
          parent: sqlServer
          name: 'default'
          properties: {
            state: 'Enabled'
            storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
            storageAccountAccessKey: environmentName == 'Production' ? auditStorageAccount.listKeys().keys[0].value : ''
          }
        }
        ```
        - NOTICE that the definition includes the same if condition as the storage account. 
          + Also, the **storageEndpoint** and **storageAccountAccessKey** properties use the question mark (**?**) ternary operator to ensure that their values are always valid. 
          + If you don't do this, Azure Resource Manager evaluates the expression values before it evaluates the resource deployment condition and returns an error, because the storage account can't be found.

    4. Verify your Bicep file
        - After you've completed all of the preceding changes, your Bicep file should look like this example:
        ```Bicep
        @description('The Azure region into which the resources should be deployed.')
        param location string

        @secure()
        @description('The administrator login username for the SQL server.')
        param sqlServerAdministratorLogin string

        @secure()
        @description('The administrator login password for the SQL server.')
        param sqlServerAdministratorLoginPassword string

        @description('The name and tier of the SQL database SKU.')
        param sqlDatabaseSku object = {
          name: 'Free'
          tier: 'Free'
        }

        @description('The name of the environment. This must be Development or Production.')
        @allowed([
          'Development'
          'Production'
        ])
        param environmentName string = 'Development'

        @description('The name of the audit storage account SKU.')
        param auditStorageAccountSkuName string = 'Standard_LRS'

        var sqlServerName = 'teddy${location}${uniqueString(resourceGroup().id)}'
        var sqlDatabaseName = 'TeddyBear'
        var auditingEnabled = environmentName == 'Production'
        var auditStorageAccountName = take('bearaudit${location}${uniqueString(resourceGroup().id)}', 24)

        resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
          name: sqlServerName
          location: location
          properties: {
            administratorLogin: sqlServerAdministratorLogin
            administratorLoginPassword: sqlServerAdministratorLoginPassword
          }
        }

        resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
          parent: sqlServer
          name: sqlDatabaseName
          location: location
          sku: sqlDatabaseSku
        }

        resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = if (auditingEnabled) {
          name: auditStorageAccountName
          location: location
          sku: {
            name: auditStorageAccountSkuName
          }
          kind: 'StorageV2'  
        }

        resource sqlServerAudit 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
          parent: sqlServer
          name: 'default'
          properties: {
            state: 'Enabled'
            storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
            storageAccountAccessKey: environmentName == 'Production' ? auditStorageAccount.listKeys().keys[0].value : ''
          }
        }
        ```

    5. Deploy the Bicep template to Azure
        1. Install Bicep: `az bicep install && az bicep upgrade`
        2. Sign in to Azure: `az login`
           - Get the Concierge Subscription IDs: 
            ```
            az account list --refresh --query "[?contains(name, 'Concierge Subscription')].id" --output table
            ```

          - Set the default subscription by using the subscription ID
            ```
            az account set --subscription {your subscription ID}
            ```

        3. Set the default resource group
          ```
          az group create --name rg-mslearn --location eastasia
          az configure --defaults group="[sandbox resource group name]"
          ```

    6. Deploy the template to Azure by using the Azure CLI
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep --parameters location=eastasia
        ```
        - NOTICE:
          + You're prompted to enter the values for **sqlServerAdministratorLogin** and **sqlServerAdministratorLoginPassword** parameters when you execute the deployment.
          + TIP:
            - When you enter the secure parameters, the values you choose must follow certain rules:
              + **sqlServerAdministratorLogin** must not be an easily guessable login name such as **admin** or **root**.
                - It can contain only alphanumeric characters and must start with a letter.

              + **sqlServerAdministratorLoginPassword** must be at least eight characters long and include lowercase letters, uppercase letters, numbers, and symbols. 
                - For more information about password complexity, see the **SQL Azure password policy**.
                  + https://learn.microsoft.com/en-us/sql/relational-databases/security/password-policy#password-complexity
              
              + If the parameter values don't meet the requirements, Azure SQL won't deploy your logical server.

               + Also, be sure to note the login and password that you enter. You'll use them again shortly.

    7. Verify the deployment
        - Go to Resource group on Azure portal, open deployment section

    8. Redeploy for the production environment
        1. Deploy the template for the production environment
            ```Azure CLI
            az deployment group create --name main --template-file main.bicep --parameters environmentName=Production location=westus3
            ```
            - CAUTION:
              + Be sure to use the same login and password that you used previously, or the deployment won't finish successfully.

        2. Verify the redeployment
            1. Select your logical server (look for the resource with type SQL server).
            2. In the search field, enter **Auditing**. Under **Security**, select **Auditing**.
            3. Verify that auditing is enabled for this logical server

4. Deploy multiple resources by using loops
    - Often, you need to deploy multiple resources that are very similar. 
      + By adding loops to your Bicep files, you can avoid having to repeat resource definitions. 
      + Instead, you can dynamically set the number of instances of a resource you want to deploy.
      + You can even customize the properties for each instance.

    - For your toy company, you need to deploy back-end infrastructure, including some Azure SQL logical servers, to support the launch of the new smart teddy bear.
      + You need to deploy a dedicated logical server to each country/region where the toy will be available, so that you're in compliance with each country/region's data-protection laws.

    - Apart from their locations, all logical servers will be configured in the same way.
      + You want to use Bicep code to deploy your logical servers, and a parameter should allow you to specify the regions into which the logical servers should be deployed.

    - In this unit, you learn how to deploy multiple instances of resources by using **copy loops**.

    1. Use copy loops
      - **for ... in** keyword
      - Opening bracket (**[**) character before the for keyword, and a closing bracket (**]**) character after the resource definition.

        ```Bicep
        param storageAccountNames array = [
          'saauditus'
          'saauditeurope'
          'saauditapac'
        ]

        resource storageAccountResources 'Microsoft.Storage/storageAccounts@2023-05-01' = [for storageAccountName in storageAccountNames: {
          name: storageAccountName
          location: resourceGroup().location
          kind: 'StorageV2'
          sku: {
            name: 'Standard_LRS'
          }
        }]
        ```

    2. Loop based on a count
      - **range()** function
        + **range(0,3)**, **range(3)**, **range(3,4) - 3, 4, 5, and 6**

        ```Bicep
        resource storageAccountResources 'Microsoft.Storage/storageAccounts@2023-05-01' = [for i in range(1,4): {
          name: 'sa${i}'
          location: resourceGroup().location
          kind: 'StorageV2'
          sku: {
            name: 'Standard_LRS'
          }
        }]
        ```

    3. Access the iteration index
        - **[for (location, i) in locations: {}]**
        ```Bicep
        param locations array = [
          'westeurope'
          'eastus2'
          'eastasia'
        ]

        resource sqlServers 'Microsoft.Sql/servers@2024-05-01-preview' = [for (location, i) in locations: {
          name: 'sqlserver-${i+1}'
          location: location
          properties: {
            administratorLogin: administratorLogin
            administratorLoginPassword: administratorLoginPassword
          }
        }]
        ```

    4. Filter items with loops
      - combining the **if** and **for** keywords
        ```Bicep
        param sqlServerDetails array = [
          {
            name: 'sqlserver-we'
            location: 'westeurope'
            environmentName: 'Production'
          }
          {
            name: 'sqlserver-eus2'
            location: 'eastus2'
            environmentName: 'Development'
          }
          {
            name: 'sqlserver-eas'
            location: 'eastasia'
            environmentName: 'Production'
          }
        ]

        resource sqlServers 'Microsoft.Sql/servers@2024-05-01-preview' = [for sqlServer in sqlServerDetails: if (sqlServer.environmentName == 'Production') {
          name: sqlServer.name
          location: sqlServer.location
          properties: {
            administratorLogin: administratorLogin
            administratorLoginPassword: administratorLoginPassword
          }
          tags: {
            environment: sqlServer.environmentName
          }
        }]
        ```

5. Exercise - Deploy multiple resources by using loops
    - So far, your Bicep template has deployed a single Azure SQL logical server, with auditing settings included for your production environment. 
      + You now need to deploy multiple logical servers, one for each region where your company is launching its new smart teddy bear.

    - In this exercise, you'll extend the Bicep code that you created previously so that you can deploy instances of your databases to multiple Azure regions.

    1. Move resources into a module
        - Create **modules/database.bicep** and **main.bicep**

    2. Deploy multiple instances by using a copy loop

    3. Verify your Bicep file
        - **main.bicep**:
          ```Bicep
          @description('The Azure regions into which the resources should be deployed.')
          param locations array = [
            'westus'
            'eastus2'
          ]

          @secure()
          @description('The administrator login username for the SQL server.')
          param sqlServerAdministratorLogin string

          @secure()
          @description('The administrator login password for the SQL server.')
          param sqlServerAdministratorLoginPassword string

          module databases 'modules/database.bicep' = [for location in locations: {
            name: 'database-${location}'
            params: {
              location: location
              sqlServerAdministratorLogin: sqlServerAdministratorLogin
              sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
            }
          }]
          ```

        - **modules/database.bicep**:
          ```Bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string

          @secure()
          @description('The administrator login username for the SQL server.')
          param sqlServerAdministratorLogin string

          @secure()
          @description('The administrator login password for the SQL server.')
          param sqlServerAdministratorLoginPassword string

          @description('The name and tier of the SQL database SKU.')
          param sqlDatabaseSku object = {
            name: 'Free'
            tier: 'Free'
          }

          @description('The name of the environment. This must be Development or Production.')
          @allowed([
            'Development'
            'Production'
          ])
          param environmentName string = 'Development'

          @description('The name of the audit storage account SKU.')
          param auditStorageAccountSkuName string = 'Standard_LRS'

          var sqlServerName = 'teddy${location}${uniqueString(resourceGroup().id)}'
          var sqlDatabaseName = 'TeddyBear'
          var auditingEnabled = environmentName == 'Production'
          var auditStorageAccountName = take('bearaudit${location}${uniqueString(resourceGroup().id)}', 24)

          resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
            name: sqlServerName
            location: location
            properties: {
              administratorLogin: sqlServerAdministratorLogin
              administratorLoginPassword: sqlServerAdministratorLoginPassword
            }
          }

          resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
            parent: sqlServer
            name: sqlDatabaseName
            location: location
            sku: sqlDatabaseSku
          }

          resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = if (auditingEnabled) {
            name: auditStorageAccountName
            location: location
            sku: {
              name: auditStorageAccountSkuName
            }
            kind: 'StorageV2'  
          }

          resource sqlServerAudit 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
            parent: sqlServer
            name: 'default'
            properties: {
              state: 'Enabled'
              storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
              storageAccountAccessKey: environmentName == 'Production' ? auditStorageAccount.listKeys().keys[0].value : ''
            }
          }
          ```

    4. Deploy the Bicep template to Azure
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep
        ```

    5. Verify the deployment

    6. Update and redeploy the template to Azure with an additional location for a logical server
        - update: add location 'eastasia'
        - redeploy:
          ```Azure CLI
          az deployment group create --name main --template-file main.bicep
          ```

    7. Verify the redeployment


6. Control loop execution and nest loops
    1. Control loop execution
        - By default, Azure Resource Manager creates resources from loops in parallel and in a non-deterministic order.
        - **@batchSize** decorator and **for** keyword
          ```Bicep
          @batchSize(2)
          resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = [for i in range(1,3): {
            name: 'app${i}'
            // ...
          }]
          ```

    2. Use loops with resource properties
        - For example, when you deploy a virtual network, you need to specify its subnets. 
          + A subnet has to have two pieces of important information: a name and an address prefix. 
        
        - You can use a parameter with an array of objects so that you can specify different subnets for each environment:
          ```Bicep
          param subnetNames array = [
            'api'
            'worker'
          ]

          resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
            name: 'teddybear'
            location: resourceGroup().location
            properties: {
              addressSpace: {
                addressPrefixes: [
                  '10.0.0.0/16'
                ]
              }
              // NEW
              subnets: [for (subnetName, i) in subnetNames: {
                name: subnetName
                properties: {
                  addressPrefix: '10.0.${i}.0/24'
                }
              }]
            }
          }
          ```

    3. Nested loops
        - For your teddy bear toy company, you need to deploy virtual networks in every country/region where the toy will be launched.
          + Every virtual network needs a different address space and two subnets.
        - Let's start by deploying the virtual networks in a loop:
          ```Bicep
          param locations array = [
            'westeurope'
            'eastus2'
            'eastasia'
          ]

          var subnetCount = 2

          resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for (location, i) in locations : {
            name: 'vnet-${location}'
            location: location
            properties: {
              addressSpace:{
                addressPrefixes:[
                  '10.${i}.0.0/16'
                ]
              }
            }
          }]
          ```

        - You can use a nested loop to deploy the subnets within each virtual network:
          ```Bicep
          resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for (location, i) in locations : {
            name: 'vnet-${location}'
            location: location
            properties: {
              addressSpace:{
                addressPrefixes:[
                  '10.${i}.0.0/16'
                ]
              }
              subnets: [for j in range(1, subnetCount): {
                name: 'subnet-${j}'
                properties: {
                  addressPrefix: '10.${i}.${j}.0/24'
                }
              }]
            }
          }]
          ```

        - When you deploy the template, you get the following virtual networks and subnets:
          ```
          Virtual network name	  Location	  Address prefix	  Subnets
          vnet-westeurope	        westeurope	10.0.0.0/16	      10.0.1.0/24, 10.0.2.0/24
          vnet-eastus2	          eastus2	    10.1.0.0/16	      10.1.1.0/24, 10.1.2.0/24
          vnet-eastasia	          eastasia	  10.2.0.0/16	      10.2.1.0/24, 10.2.2.0/24
          ```

7. Use variable and output loops
    - For your toy company, you need to deploy virtual networks with the same subnet configuration across multiple Azure regions.
      + You expect that you'll need to add additional subnets to your virtual networks in the future, so you want to have the flexibility in your Bicep templates to modify the subnet configuration.

    - Because you'll also be deploying multiple storage accounts in your Azure environment, you need to provide the endpoints for each storage account as output so that your deployment pipelines can use this information.

    - In this unit, you'll learn how to use loops with variables and outputs.

    1. Variable loops
        - Usage
          ```bicep
          var items = [for i in range(1, 5): 'item${i}']
          ```

        - You'd ordinarily use variable loops to create more complex objects that you could then use within a resource declaration.
        - Here's how to use variable loops to create a subnets property:
          ```Bicep
          param addressPrefix string = '10.10.0.0/16'
          param subnets array = [
            {
              name: 'frontend'
              ipAddressRange: '10.10.0.0/24'
            }
            {
              name: 'backend'
              ipAddressRange: '10.10.1.0/24'
            }
          ]

          // NEW
          var subnetsProperty = [for subnet in subnets: {
            name: subnet.name
            properties: {
              addressPrefix: subnet.ipAddressRange
            }
          }]

          resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
            name: 'teddybear'
            location: resourceGroup().location
            properties:{
              addressSpace:{
                addressPrefixes:[
                  addressPrefix
                ]
              }
              subnets: subnetsProperty
            }
          }
          ```


    2. Output loops
        - usage
          ```Bicep
          var items = [
            'item1'
            'item2'
            'item3'
            'item4'
            'item5'
          ]

          output outputItems array = [for i in range(0, length(items)): items[i]]
          ```

        - You'll ordinarily use output loops in conjunction with other loops within your template. 
        - For example, let's look at a Bicep file that deploys a set of storage accounts to Azure regions that are specified by the **locations** parameter:
          ```Bicep
          param locations array = [
            'westeurope'
            'eastus2'
            'eastasia'
          ]

          resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-05-01' = [for location in locations: {
            name: 'toy${uniqueString(resourceGroup().id, location)}'
            location: location
            kind: 'StorageV2'
            sku: {
              name: 'Standard_LRS'
            }
          }]
          ```

          + You'll probably need to return information about each storage account that you've created, such as its name and the endpoints that can be used to access it.
          + NOTE: Currently, Bicep doesn't support directly referencing resources that have been created within a loop from within an output loop. This means that you need to use array indexers to access the resources, as shown in the next example.
            ```Bicep
            output storageEndpoints array = [for i in range(0, length(locations)): {
              name: storageAccounts[i].name
              location: storageAccounts[i].location
              blobEndpoint: storageAccounts[i].properties.primaryEndpoints.blob
              fileEndpoint: storageAccounts[i].properties.primaryEndpoints.file
            }]
            ```
            - CAUTION: Don't use outputs to return secrets, such as access keys or passwords. 
              + Outputs are logged, and they aren't designed for handling secure data.

8. Exercise - Use variable and output loops
    - For your toy company, you need to deploy virtual networks in each country/region where you're launching the teddy bear.
      + Your developers have also asked you to give them the fully qualified domain names (FQDNs) of each of the regional Azure SQL logical servers you've deployed.

    - In this exercise, you'll add the virtual network and its configuration to your Bicep code, and you'll output the logical server FQDNs.

    1. Add the virtual network to your Bicep file
    2. Add outputs to the database module
    3. Flow the outputs through the parent Bicep file
    4. Verify your Bicep file
        - **main.bicep**:
          ```Bicep
          @description('The Azure regions into which the resources should be deployed.')
          param locations array = [
            'westeurope'
            'eastus2'
            'eastasia'
          ]

          @secure()
          @description('The administrator login username for the SQL server.')
          param sqlServerAdministratorLogin string

          @secure()
          @description('The administrator login password for the SQL server.')
          param sqlServerAdministratorLoginPassword string

          @description('The IP address range for all virtual networks to use.')
          param virtualNetworkAddressPrefix string = '10.10.0.0/16'

          @description('The name and IP address range for each subnet in the virtual networks.')
          param subnets array = [
            {
              name: 'frontend'
              ipAddressRange: '10.10.5.0/24'
            }
            {
              name: 'backend'
              ipAddressRange: '10.10.10.0/24'
            }
          ]

          var subnetProperties = [for subnet in subnets: {
            name: subnet.name
            properties: {
              addressPrefix: subnet.ipAddressRange
            }
          }]

          module databases 'modules/database.bicep' = [for location in locations: {
            name: 'database-${location}'
            params: {
              location: location
              sqlServerAdministratorLogin: sqlServerAdministratorLogin
              sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
            }
          }]

          resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for location in locations: {
            name: 'teddybear-${location}'
            location: location
            properties:{
              addressSpace:{
                addressPrefixes:[
                  virtualNetworkAddressPrefix
                ]
              }
              subnets: subnetProperties
            }
          }]

          output serverInfo array = [for i in range(0, length(locations)): {
            name: databases[i].outputs.serverName
            location: databases[i].outputs.location
            fullyQualifiedDomainName: databases[i].outputs.serverFullyQualifiedDomainName
          }]
          ```

        - **modules/database.bicep** file:
          ```Bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string

          @secure()
          @description('The administrator login username for the SQL server.')
          param sqlServerAdministratorLogin string

          @secure()
          @description('The administrator login password for the SQL server.')
          param sqlServerAdministratorLoginPassword string

          @description('The name and tier of the SQL database SKU.')
          param sqlDatabaseSku object = {
            name: 'Free'
            tier: 'Free'
          }

          @description('The name of the environment. This must be Development or Production.')
          @allowed([
            'Development'
            'Production'
          ])
          param environmentName string = 'Development'

          @description('The name of the audit storage account SKU.')
          param auditStorageAccountSkuName string = 'Standard_LRS'

          var sqlServerName = 'teddy${location}${uniqueString(resourceGroup().id)}'
          var sqlDatabaseName = 'TeddyBear'
          var auditingEnabled = environmentName == 'Production'
          var auditStorageAccountName = take('bearaudit${location}${uniqueString(resourceGroup().id)}', 24)

          resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
            name: sqlServerName
            location: location
            properties: {
              administratorLogin: sqlServerAdministratorLogin
              administratorLoginPassword: sqlServerAdministratorLoginPassword
            }
          }

          resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
            parent: sqlServer
            name: sqlDatabaseName
            location: location
            sku: sqlDatabaseSku
          }

          resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = if (auditingEnabled) {
            name: auditStorageAccountName
            location: location
            sku: {
              name: auditStorageAccountSkuName
            }
            kind: 'StorageV2'  
          }

          resource sqlServerAudit 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
            parent: sqlServer
            name: 'default'
            properties: {
              state: 'Enabled'
              storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
              storageAccountAccessKey: environmentName == 'Production' ? listKeys(auditStorageAccount.id, auditStorageAccount.apiVersion).keys[0].value : ''
            }
          }

          output serverName string = sqlServer.name
          output location string = location
          output serverFullyQualifiedDomainName string = sqlServer.properties.fullyQualifiedDomainName
          ```

    5. Deploy the Bicep template to Azure
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep
        ```
        - CAUTION: Be sure to use the same login and password that you used previously, or the deployment won't finish successfully.

    6. Verify the deployment
        - Check virtual network named **teddybear-eastasia**, subnets, and Outputs

9. Summary
    - Your toy company wants to launch a new teddy bear toy in multiple countries/regions. 
      + For compliance reasons, the infrastructure must be spread across all the Azure regions where the toy will be launched.

    - You needed to deploy the same resources in multiple locations and a variety of environments.
      + You wanted to create flexible Bicep templates that you can reuse, and to control resource deployments by changing the deployment parameters.

    - To deploy some resources only to certain environments, you added conditions to your template. You then used copy loops to deploy resources into various Azure regions.
      + You used variable loops to define the properties of the resources to be deployed.
      + Finally, you used output loops to retrieve the properties of those deployed resources.

    - Without the conditions and copy loops features, you'd have to maintain and use multiple versions of Bicep templates.
      + You'd have to apply every change in your environment in multiple templates.
      + Maintaining all these templates would entail a great deal of effort and overhead.
      + By using conditions and loops, you were able to create a single template that works for all your regions and environments and ensure that all your resources are configured identically.

10. Learn more
    - Conditional deployment in Bicep: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/conditional-resource-deployment
    - Bicep loops: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/loops
    - Resources: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/resource-declaration
    - Modules: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules
    - Variables: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/variables
    - Outputs: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/outputs

## Create composable Bicep files by using modules
- https://learn.microsoft.com/en-us/training/modules/create-composable-bicep-files-using-modules

1. Introduction
    1. Example scenario
        - Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company.
          + You've previously created a Bicep template that deploys websites to support the launch of each new toy product.

        - Your company recently launched a new toy: a remote control wombat.
          + The wombat toy has become popular, and the traffic to its website has increased significantly.
          + Customers are complaining about slow response times because the server can't keep up with the demand.

        - To improve performance and reduce cost, you've been asked to add a content delivery network, or CDN, to the website.
          + You know that your company will need to include a CDN in other websites that it makes in the future, but also that not every website needs a CDN.
          + So you decide to make the CDN component optional.

        ```Design
        Internet 
          -> CDN enabled (CDN -> App Service app; App Service plan)
          -> CDN not enabled (App Service app; App Service plan)
        ```

2. Create and use Bicep modules
    1. The benefits of modules
        1. Reusability
            - For example, when you build out one solution, you might create separate modules for the app components, the database, and the network-related resources.
              + Then, when you start to work on another project with similar network requirements, you can reuse the relevant module.

        2. Encapsulation
            - For example, when you define an Azure Functions app, you typically deploy the app, a hosting plan for the app, and a storage account for the app's metadata.
              + These three components are defined separately, but they represent a logical grouping of resources, so it might make sense to define them as a module.

            - That way, your main template doesn't need to be aware of the details of how a function app is deployed. That's the responsibility of the module.

        3. Composability
            - For example, you might create a module that deploys a virtual network, and another module that deploys a virtual machine.
              + You define parameters and outputs for each module so that you can take the important information from one and send it to the other.

        4. Functionality
            - Occasionally, you might need to use modules to access certain functionality.
            - For example, you can use modules and loops together to deploy multiple sets of resources.

    2. Create a module
        1. Split an existing Bicep template into modules
        2. Nest modules
            - Modules can include other modules. 
              + By using this nesting technique, you can create some modules that deploy small sets of resources, then compose these into larger modules that define complex topologies of resources.
              + A template combines these pieces into a deployable artifact.

            - TIP: For complex deployments, sometimes it makes sense to use deployment pipelines to deploy multiple templates instead of creating a single template that does everything with nesting.

        3. Choose good file names
            - Be sure to use a descriptive file name for each module. 
              + The file name effectively becomes the identifier for the module. 
              + It's important that your colleagues can understand the module's purpose just by looking at the file name.

    3. Use the module in a Bicep template
        - Use **module** keyword
          ```Bicep
          module appModule 'modules/app.bicep' = {
            name: 'myApp'
            params: {
              location: location
              appServiceAppName: appServiceAppName
              environmentType: environmentType
            }
          }
          ```
          + A symbolic name, like **appModule**, is used within this Bicep file whenever you want to refer to the module.
            - The symbolic name never appears in Azure.
          + **name** property, which specifies the name of the deployment
          + **params** property: where you can specify values for the parameters that the module expects. 

    4. How modules work
        - Understanding how modules work isn't necessary for using them, but it can help you investigate problems with your deployments or help explain unexpected behavior.

        1. Deployments
            - In Azure, a deployment is a special resource that represents a deployment operation. 
              + Deployments are Azure resources that have the resource type **Microsoft.Resources/deployments**.
              + When you submit a Bicep deployment, you create or update a deployment resource.
              + Similarly, when you create resources in the Azure portal, the portal creates a deployment resource on your behalf.

        2. Generated JSON ARM templates
            - When you deploy a Bicep file, Bicep converts it to a JSON ARM template.
              + This conversion is also called **transpilation**.
              + The modules that the template uses are embedded into the JSON file.
              + Regardless of how many modules you include in your template, only a single JSON file will be created.

3. Add parameters and outputs to modules
    1. Module parameters
        - You should also think about how you manage parameters that control the SKUs for your resources and other important configuration settings. 
        - For example: When I deploy a production environment, the storage account should use the GRS tier.
          + But modules sometimes present different concerns.

    2. Use conditions
        ```
        param logAnalyticsWorkspaceId string = ''

        resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2022-08-15' = {
          // ...
        }

        resource cosmosDBAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =  if (logAnalyticsWorkspaceId != '') {
          scope: cosmosDBAccount
          name: 'route-logs-to-log-analytics'
          properties: {
            workspaceId: logAnalyticsWorkspaceId
            logs: [
              {
                category: 'DataPlaneRequests'
                enabled: true
              }
            ]
          }
        }
        ```

    3. Module outputs
        ```
        @description('The fully qualified Azure resource ID of the blob container within the storage account.')
        output blobContainerResourceId string = storageAccount::blobService::container.id
        ```
        - TIP: You can also use dedicated services to store, manage, and access the settings that your Bicep template creates.
          + Key Vault is designed to store secure values.
          + **Azure App Configuration** is designed to store other (non-secure) values.

    4. Chain modules together
        ```Bicep
        @description('Username for the virtual machine.')
        param adminUsername string

        @description('Password for the virtual machine.')
        @minLength(12)
        @secure()
        param adminPassword string

        module virtualNetwork 'modules/vnet.bicep' = {
          name: 'virtual-network'
        }

        module virtualMachine 'modules/vm.bicep' = {
          name: 'virtual-machine'
          params: {
            adminUsername: adminUsername
            adminPassword: adminPassword
            subnetResourceId: virtualNetwork.outputs.subnetResourceId
          }
        }
        ```

4. Exercise - Create and use a module
    - You've been tasked with adding a content delivery network, or CDN, to your company's website for the launch of a toy wombat.
      + However, other teams in your company have told you they don't need a CDN.
      + In this exercise, you'll create modules for the website and the CDN, and you'll add the modules to a template.

    1. Create a blank Bicep file: **main.bicep**
    2. Create a module for your application
        - **modules/app.bicep** file:
          ```
          @description('The Azure region into which the resources should be deployed.')
          param location string

          @description('The name of the App Service app.')
          param appServiceAppName string

          @description('The name of the App Service plan.')
          param appServicePlanName string

          @description('The name of the App Service plan SKU.')
          param appServicePlanSkuName string

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

          @description('The default host name of the App Service app.')
          output appServiceAppHostName string = appServiceApp.properties.defaultHostName
          ```

    3. Add the module to your Bicep template
        - Select **Required properties** from the pop-up menu:
          ```bicep
          module app 'modules/app.bicep' = {
            name: 'toy-launch-app'
            params: {
              appServiceAppName: appServiceAppName
              appServicePlanName: appServicePlanName
              appServicePlanSkuName: appServicePlanSkuName
              location: location
            }
          }
          ```

    4. Create a module for the content delivery network
        - **modules/cdn.bicep** file:
          ```bicep
          @description('The host name (address) of the origin server.')
          param originHostName string

          @description('The name of the CDN profile.')
          param profileName string = 'cdn-${uniqueString(resourceGroup().id)}'

          @description('The name of the CDN endpoint')
          param endpointName string = 'endpoint-${uniqueString(resourceGroup().id)}'

          @description('Indicates whether the CDN endpoint requires HTTPS connections.')
          param httpsOnly bool

          var originName = 'my-origin'

          resource cdnProfile 'Microsoft.Cdn/profiles@2024-09-01' = {
            name: profileName
            location: 'global'
            sku: {
              name: 'Standard_Microsoft'
            }
          }

          resource endpoint 'Microsoft.Cdn/profiles/endpoints@2024-09-01' = {
            parent: cdnProfile
            name: endpointName
            location: 'global'
            properties: {
              originHostHeader: originHostName
              isHttpAllowed: !httpsOnly
              isHttpsAllowed: true
              queryStringCachingBehavior: 'IgnoreQueryString'
              contentTypesToCompress: [
                'text/plain'
                'text/html'
                'text/css'
                'application/x-javascript'
                'text/javascript'
              ]
              isCompressionEnabled: true
              origins: [
                {
                  name: originName
                  properties: {
                    hostName: originHostName
                  }
                }
              ]
            }
          }

          @description('The host name of the CDN endpoint.')
          output endpointHostName string = endpoint.properties.hostName
          ```
          - This file deploys two resources: a CDN profile and a CDN endpoint.


    5. Add the modules to the main Bicep template

    6. Verify your Bicep file
        - **main.bicep**:
          ```bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string = 'westus3'

          @description('The name of the App Service app.')
          param appServiceAppName string = 'toy-${uniqueString(resourceGroup().id)}'

          @description('The name of the App Service plan SKU.')
          param appServicePlanSkuName string = 'F1'

          @description('Indicates whether a CDN should be deployed.')
          param deployCdn bool = true

          var appServicePlanName = 'toy-product-launch-plan'

          module app 'modules/app.bicep' = {
            name: 'toy-launch-app'
            params: {
              appServiceAppName: appServiceAppName
              appServicePlanName: appServicePlanName
              appServicePlanSkuName: appServicePlanSkuName
              location: location
            }
          }

          module cdn 'modules/cdn.bicep' = if (deployCdn) {
            name: 'toy-launch-cdn'
            params: {
              httpsOnly: true
              originHostName: app.outputs.appServiceAppHostName
            }
          }

          @description('The host name to use to access the website.')
          output websiteHostName string = deployCdn ? cdn.outputs.endpointHostName : app.outputs.appServiceAppHostName
          ```

        - **modules/app.bicep** file:
          ```Bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string

          @description('The name of the App Service app.')
          param appServiceAppName string

          @description('The name of the App Service plan.')
          param appServicePlanName string

          @description('The name of the App Service plan SKU.')
          param appServicePlanSkuName string

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

          @description('The default host name of the App Service app.')
          output appServiceAppHostName string = appServiceApp.properties.defaultHostName
          ```

        - **modules/cdn.bicep** file:
          ```bicep
          @description('The host name (address) of the origin server.')
          param originHostName string

          @description('The name of the CDN profile.')
          param profileName string = 'cdn-${uniqueString(resourceGroup().id)}'

          @description('The name of the CDN endpoint')
          param endpointName string = 'endpoint-${uniqueString(resourceGroup().id)}'

          @description('Indicates whether the CDN endpoint requires HTTPS connections.')
          param httpsOnly bool

          var originName = 'my-origin'

          resource cdnProfile 'Microsoft.Cdn/profiles@2024-09-01' = {
            name: profileName
            location: 'global'
            sku: {
              name: 'Standard_Microsoft'
            }
          }

          resource endpoint 'Microsoft.Cdn/profiles/endpoints@2024-09-01' = {
            parent: cdnProfile
            name: endpointName
            location: 'global'
            properties: {
              originHostHeader: originHostName
              isHttpAllowed: !httpsOnly
              isHttpsAllowed: true
              queryStringCachingBehavior: 'IgnoreQueryString'
              contentTypesToCompress: [
                'text/plain'
                'text/html'
                'text/css'
                'application/x-javascript'
                'text/javascript'
              ]
              isCompressionEnabled: true
              origins: [
                {
                  name: originName
                  properties: {
                    hostName: originHostName
                  }
                }
              ]
            }
          }

          @description('The host name of the CDN endpoint.')
          output endpointHostName string = endpoint.properties.hostName
          ```
    7. Deploy the Bicep template to Azure
        ```
        az deployment group create --name main --template-file main.bicep
        ```

    8. Review the deployment history

    9. Test the website
        - When the CDN endpoint is active, you'll get the same App Service welcome page.
          + This time, it has been served through the Azure Content Delivery Network service, which helps improve the website's performance.

5. Summary
    - Your company's new toy wombat is a success. However, the large amount of traffic to the website was causing performance problems and customer complaints.
      + You needed to add a content delivery network, or CDN, to the website to help it better support the load.
      + You wanted to do this in a reusable and composable way, because you knew that other websites and other projects in your company would also need a CDN in the future.

    - In this module, you learned how to create and use Bicep modules to make your Bicep code reusable, better structured, and composable.
      + You learned about the importance of creating good parameters and outputs for your modules to ensure that they're easy to chain together and compose into other templates, or even other modules.
      + You also learned how conditions can help add flexibility to your modules.

    - Now you can easily add a CDN into any of the websites that you create, whether or not they're deployed from your website's main template. 

# Part 2: Intermediate Bicep: https://learn.microsoft.com/en-us/training/paths/intermediate-bicep/

## Deploy child and extension resources by using Bicep
1. Example scenario
    - Suppose you're responsible for deploying and configuring Azure infrastructure at a toy company.
      + Your company's R&D department contacts you because they're working on a new toy drone that sprays glitter over unsuspecting targets.
      + R&D team members are starting to test the drone.
      + They plan to collect telemetry about the distance the drone can fly, the amount of glitter it can spray, and the battery level.

    - They want you to set up a new Azure Cosmos DB database for storing this valuable and highly sensitive product test data.
    + They need you to log all database-access attempts so that they can feel confident that no competitors are accessing the data.

    - The team created a storage account to store all their product design documents, and they want you to help audit all attempts to access them.

2. Understand Azure resources
    - All Azure resources are deployed with a specific type.
      +  The type identifies the kind of resource it is.
      + A resource ID is the way Azure identifies a specific instance of a resource.
      + It's important to understand how resource types and resource IDs are structured, because they give you important information when you're writing Bicep templates.

    1. Resource providers
        - Azure Resource Manager is designed so that many different **resource providers** can be managed through Resource Manager APIs and ARM templates.
          + A resource provider is a logical grouping of resource types, which usually relate to one or a few Azure services. 
        
        - Examples of resource providers include:
          + **Microsoft.Compute**: which is used for virtual machines.
          + **Microsoft.Network**: which is used for networking resources like virtual networks, network security groups, and route tables.
          + **Microsoft.Cache**: which is used for Azure Cache for Redis.
          + **Microsoft.Sql**: which is used for Azure SQL.
          + **Microsoft.Web**: which is used for Azure App Service and Azure Functions.
          + **Microsoft.DocumentDB**: which is used for Azure Cosmos DB.

    2. Resource types
        - A resource provider exposes multiple different types. Each resource type has its own set of properties and behaviors that define the resource and what it can do. 
        - For example, within the **Microsoft.Web** resource provider, there are several resource types, including:
          + **sites**: Defines an App Service application or Azure Functions application.
            - Properties include the environment variables that your application uses, and the supported protocols (HTTP and HTTPS) to access the application

          + **serverFarms**: Defines an App Service plan, the infrastructure that runs your applications.
            - Properties include the size and SKU of the servers, and the number of instances of your plan that you want to deploy.

        - You combine the **resource provider** and **resource type** name to make a fully qualified resource type name.
          + For example, a storage account’s fully qualified type name is **Microsoft.Storage/storageAccounts**

    3. Resource IDs
        - Every Azure resource has a unique resource ID.
          + This ID includes information that helps disambiguate the resource from any other resource of the same type, or even from different resources that might share the same name.
        - A resource ID for a storage account looks like this:
          ```
          /subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345/resourceGroups/ToyDevelopment/providers/Microsoft.Storage/storageAccounts/secrettoys
          ```

3. Define child resources
    - It makes sense to deploy some resources only within the context of their parent.
      + These resources are called child resources.
      + There are many child resource types in Azure.
    - Here are a few examples:
      ```
      Virtual network subnets	      Microsoft.Network/virtualNetworks/subnets
      App Service configuration	    Microsoft.Web/sites/config
      SQL databases	                Microsoft.Sql/servers/databases
      Virtual machine extensions	  Microsoft.Compute/virtualMachines/extensions
      Storage blob containers	      Microsoft.Storage/storageAccounts/blobServices/containers
      Azure Cosmos DB containers	  Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers
      ```

    1. How are child resources defined?
        - With Bicep, you can declare child resources in several different ways.
          1. Nested resources
              - One approach to defining a child resource is to nest the child resource inside the parent.
                ```bicep
                resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
                name: vmName
                location: location
                properties: {
                  // ...
                }

                // NEW, nested resource
                resource installCustomScriptExtension 'extensions' = {
                  name: 'InstallCustomScript'
                  location: location
                  properties: {
                    // ...
                  }
                }
              }
              ```
              + You can refer to a nested resource by using the **::** operator
                ```bicep
                output childResourceId string = vm::installCustomScriptExtension.id
                ```

          2. Parent property
              - A second approach is to use the **parent** property
                ```bicep
                resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
                  name: vmName
                  location: location
                  properties: {
                    // ...
                  }
                }

                resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
                  parent: vm
                  name: 'InstallCustomScript'
                  location: location
                  properties: {
                    // ...
                  }
                }
                ```

          3. Construct the resource name
              - There are some circumstances where you can't use nested resources or the **parent** keyword.
              - Examples include when you declare child resources within a **for** loop, or when you need to use complex expressions to dynamically select a parent resource for a child. 
                + In these situations, you can deploy a child resource by manually constructing the child resource name so that it includes its parent resource name or use **dependsOn** keyword, as shown here:
                  ```bicep
                  resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
                    name: vmName
                    location: location
                    properties: {
                      // ...
                    }
                  }

                  resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
                    name: '${vm.name}/InstallCustomScript'
                    location: location
                    properties: {
                      // ...
                    }
                  }

                  resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
                    name: '${vmName}/InstallCustomScript'
                    dependsOn: [
                      vm
                    ]
                    //...
                  }
                  ```

              - TIP: It's generally best to avoid constructing resource names, because you lose a lot of the benefits that Bicep can provide when it understands the relationships between your resources.
                + Use this option only when you can't use one of the other approaches for declaring child resources.

    3. Child resource IDs
        - For example, let's consider an Azure Cosmos DB account named **toyrnd**
          ```
          /subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd
          ```

        - Let's add a database named **FlightTests** to our Azure Cosmos DB account and take a look at the child resource ID:
          ```
          /subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd/sqlDatabases/FlightTests
          ```

        - You can have multiple levels of child resources. 
          + Here's an example resource ID that shows a storage account with two levels of children:
            ```
            /subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345/resourceGroups/ToyDevelopment/providers/Microsoft.Storage/storageAccounts/secrettoys/blobServices/default/containers/glitterspecs
            ```
            - **blobServices** indicates that the resource is within a child resource type called **blobServices**
            - **default** is the name of the blobServices child resource
            - **containers** indicates that the resource is within a child resource type called **containers**
            - **glitterspecs** is the name of the blob container

4. Exercise - Define child resources
    - You're starting to work on your R&D team's requests, and you decide to start by building an Azure Cosmos DB database for the toy drone's test data. 
      + In this exercise, you create the Azure Cosmos DB account and two child resources, one by using the parent property and the other as a nested resource.
    
    1. Create a Bicep template that contains an Azure Cosmos DB account
        - **main.bicep** file:
          ```
          param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
          param location string = resourceGroup().location

          resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-11-15' = {
            name: cosmosDBAccountName
            location: location
            properties: {
              databaseAccountOfferType: 'Standard'
              locations: [
                {
                  locationName: location
                }
              ]
            }
          }
          ```

    2. Add a database
    3. Add a container
    4. Verify your Bicep file
        - **main.bicep** file:
          ```bicep
          param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
          param cosmosDBDatabaseThroughput int = 400
          param location string = resourceGroup().location

          var cosmosDBDatabaseName = 'FlightTests'
          var cosmosDBContainerName = 'FlightTests'
          var cosmosDBContainerPartitionKey = '/droneId'

          resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-11-15' = {
            name: cosmosDBAccountName
            location: location
            properties: {
              databaseAccountOfferType: 'Standard'
              locations: [
                {
                  locationName: location
                }
              ]
            }
          }

          resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-11-15' = {
            parent: cosmosDBAccount
            name: cosmosDBDatabaseName
            properties: {
              resource: {
                id: cosmosDBDatabaseName
              }
              options: {
                throughput: cosmosDBDatabaseThroughput
              }
            }

            resource container 'containers' = {
              name: cosmosDBContainerName
              properties: {
                resource: {
                  id: cosmosDBContainerName
                  partitionKey: {
                    kind: 'Hash'
                    paths: [
                      cosmosDBContainerPartitionKey
                    ]
                  }
                }
                options: {}
              }
            }
          }
          ```

    5. Deploy the template to Azure
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep
        ```

    6. Verify the deployment
      - there's a Cosmos DB account, database, and container listed

5. Define extension resources
    - Extension resources are always attached to other Azure resources. 
      + They extend the behavior of those resources with extra functionality.

    - Some examples of common extension resources are:
      ```
      Role assignments	    Microsoft.Authorization/roleAssignments
      Policy assignments	  Microsoft.Authorization/policyAssignments
      Locks	                Microsoft.Authorization/locks
      Diagnostic settings	  Microsoft.Insights/diagnosticSettings
      ```

    - For example, consider a lock, which can be used to prevent the deletion or modification of an Azure resource.
      + It doesn't make sense to deploy a lock by itself.
      + It always has to be deployed onto another resource.

    1. How are extension resources defined?
        - add the **scope** property to tell Bicep that the resource should be attached to another resource defined elsewhere in the Bicep file

        - For example, here's the definition of an Azure Cosmos DB account that we created previously:
          ```bicep
          resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
            name: cosmosDBAccountName
            location: location
            properties: {
              // ...
            }
          }
          ```

        - Let's add a resource lock, which prevents anybody from deleting the Azure Cosmos DB account:
          ```bicep
          resource lockResource 'Microsoft.Authorization/locks@2020-05-01' = {
            scope: cosmosDBAccount // NEW, block
            name: 'DontDelete'
            properties: {
              level: 'CanNotDelete'
              notes: 'Prevents deletion of the toy data Cosmos DB account.'
            }
          }
          ```
          + NOTICE that the example uses the scope property with the Azure Cosmos DB account's symbolic name.

    2. Extension resource IDs
        - Here's what the lock's resource ID would look like:
          ```
          /subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd/providers/Microsoft.Authorization/locks/DontDelete
          ```

6. Work with existing resources
    - Bicep files often need to refer to resources that were created elsewhere. 
      + These resources might be created manually, maybe by a colleague using the Azure portal. 
      + Or they might be created in another Bicep file. 
      + There are many reasons why you need to refer to these resources, such as:
        - You're adding an SQL database into an Azure SQL logical server instance that someone already created.
        - You're configuring diagnostics settings for resources that are defined in another Bicep module.
        - You have to securely access the keys for a storage account that was manually deployed into your subscription.
    
    - Bicep provides the **existing** keyword for you to use in these situations.

    1. Refer to existing resources
        ```
        resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
          name: 'toydesigndocs'
        }
        ```
          - The **name** property is the Azure resource name of the storage account that was previously deployed.
          - You don't need to specify the **location**, **sku**, or **properties**, because the template doesn't deploy the resource.
            + It merely references an existing resource.
            + Think of it as a placeholder resource.

        1. Refer to child resources
            ```
            resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
              name: 'toy-design-vnet'

              resource managementSubnet 'subnets' existing = {
                name: 'management'
              }
            }
            ```
            - NOTICE that both the parent and child resource have the **existing** keyword applied.

        2. Refer to resources outside the resource group
            - For example, if you have a virtual network in a centralized resource group, you might want to deploy a virtual machine into that virtual network in its own resource group.

            - use the **scope** keyword to refer to existing resources in a different resource group
              ```
              resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
                scope: resourceGroup('networking-rg')
                name: 'toy-design-vnet'
              }
              ```
              + NOTICE that the **scope** uses the **resourceGroup()** keyword to refer to the resource group that contains the virtual network

            - You can even refer to resources within a different Azure subscription, as long as the subscription is within your Microsoft Entra tenant. 
              + If your networking team provisions the virtual network in a different subscription, the template could refer to it, as in this example:
                ```bicep
                resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
                  scope: resourceGroup('A123b4567c-1234-1a2b-2b1a-1234abc12345', 'networking-rg')
                  name: 'toy-design-vnet'
                }
                ```

    2. Add child and extension resources to an existing resource
        - You can add a child resource to an already-created parent resource by using a combination of the **existing** keyword and the **parent** keyword.

        - The following example template creates an Azure SQL database within a server that already exists:
          ```bicep
          // highlight
          resource server 'Microsoft.Sql/servers@2024-05-01-preview' existing = {
            name: serverName
          }

          resource database 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
            parent: server // Highlight
            name: databaseName
            location: location
            sku: {
              name: 'Standard'
              tier: 'Standard'
            }
          }
          ```

        - If you need to deploy an extension resource to an existing resource, you can use the **scope** keyword. 
        - Here's a template that uses the **existing** keyword and the **scope** keyword to add a resource lock to a storage account that already exists:
          ```bicep
          // Highlight
          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
            name: 'toydesigndocs'
          }

          resource lockResource 'Microsoft.Authorization/locks@2020-05-01' = {
            scope: storageAccount // Highlight
            name: 'DontDelete'
            properties: {
              level: 'CanNotDelete'
              notes: 'Prevents deletion of the toy design documents storage account.'
            }
          }
          ```

    3. Refer to an existing resource's properties
        - TIP: It's a best practice to look up keys from other resources in this way instead of passing them around through outputs. 
          + You'll always get the most up-to-date data. 
          + Also, importantly, outputs are not designed to handle secure data such as keys.

        - The following example template deploys an Azure Functions application, and uses the access details (**instrumentation key**) for an Application Insights instance that was already created:
          ```bicep
          resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
            name: applicationInsightsName
          }

          resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
            name: functionAppName
            location: location
            kind: 'functionapp'
            properties: {
              siteConfig: {
                appSettings: [
                  // ...
                  {
                    name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                    value: applicationInsights.properties.InstrumentationKey
                  }
                ]
              }
            }
          }
          ```

        - In this example, because the instrumentation key isn't considered sensitive data, it's available in the **properties** of the resource.   
        - When you need to access secure data, such as the credentials to use to access a resource, use the **listKeys()** function, as shown in the following code:
          ```bicep
          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
            name: storageAccountName
          }

          resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
            name: functionAppName
            location: location
            kind: 'functionapp'
            properties: {
              siteConfig: {
                appSettings: [
                  // ...
                  {
                    name: 'StorageAccountKey'
                    value: storageAccount.listKeys().keys[0].value
                  }
                ]
              }
            }
          }
          ```
          + IMPORTANT: The **listKeys()** function provides access to sensitive data about the resource.
            - This means that the user or service principal that runs the deployment needs to have the appropriate level of permission on the resource.
            - This is usually the **Contributor** built-in role, or a custom role that assigns the appropriate permission.

7. Exercise - Deploy extension resources and use existing resources
    - Now that you finished creating the database for your R&D team to use, you need to ensure that access to the database is logged.
      + You have an existing Log Analytics workspace that you want these logs to be sent to.
      + You also need to send the logs from the R&D team's storage account to the same Log Analytics workspace.
      + In this exercise, you update your Bicep file to meet these requirements.

    - During the process, you'll:
      + Create a Log Analytics workspace.
      + Update your Bicep file to add diagnostic settings to your Cosmos DB account.
      + Create a storage account.
      + In your Bicep file, update the diagnostic settings for the storage account.
      + Deploy your template and verify the result.

    1. Create a Log Analytics workspace
        - Create a Log Analytics workspace to simulate having one already created in your organization
          ```Azure CLI
          az monitor log-analytics workspace create --workspace-name ToyLogs --location eastus
          ```
          + NOTE: In this example, you're deploying the Log Analytics workspace into the same subscription and resource group as your other resources. 
            - In many situations, you'll store Log Analytics workspaces in resource groups that aren't the same as your application resources. 
            - Bicep can still reference them.

    2. Add diagnostics settings for Azure Cosmos DB
        - Your R&D team needs to log all requests to the Azure Cosmos DB account. 
          + You decide to use the **Azure Monitor integration for Azure Cosmos DB** to collect the **DataPlaneRequests** log, which contains information about requests to Azure Cosmos DB.
            - https://learn.microsoft.com/en-us/azure/cosmos-db/cosmosdb-monitor-resource-logs

        - **main.bicep** file:
          ```bicep
          var logAnalyticsWorkspaceName = 'ToyLogs'
          var cosmosDBAccountDiagnosticSettingsName = 'route-logs-to-log-analytics'

          resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
            name: logAnalyticsWorkspaceName
          }

          resource cosmosDBAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
            scope: cosmosDBAccount
            name: cosmosDBAccountDiagnosticSettingsName
            properties: {
              workspaceId: logAnalyticsWorkspace.id
              logs: [
                {
                  category: 'DataPlaneRequests'
                  enabled: true
                }
              ]
            }
          }
          ```
    
    3. Create a storage account for toy design documents
        - Create an Azure storage account to simulate your R&D team's already having created one in your organization. 
          + Use the Azure CLI instead of Bicep.

            ```Azure CLI
            az storage account create --name {storageaccountname} --location eastus
            ```

    4. Add diagnostics settings for storage account
        - Your R&D team wants you to log all successful requests to the storage account they created.
          + You decide to use the **Azure Storage integration with Azure Monitor logs** to achieve this goal.
            - https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage
          + You decide to log all read, write, and delete activities within blob storage on the R&D team's storage account.

        - update **main.bicep** file:
          ```bicep
          param storageAccountName string

          var storageAccountBlobDiagnosticSettingsName = 'route-logs-to-log-analytics'

          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
            name: storageAccountName

            resource blobService 'blobServices' existing = {
              name: 'default'
            }
          }

          resource storageAccountBlobDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
            scope: storageAccount::blobService
            name: storageAccountBlobDiagnosticSettingsName
            properties: {
              workspaceId: logAnalyticsWorkspace.id
              logs: [
                {
                  category: 'StorageRead'
                  enabled: true
                }
                {
                  category: 'StorageWrite'
                  enabled: true
                }
                {
                  category: 'StorageDelete'
                  enabled: true
                }
              ]
            }
          }
          ```

    5. Verify your Bicep file
        - **main.bicep** file:
          ```bicep
          param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
          param cosmosDBDatabaseThroughput int = 400
          param location string = resourceGroup().location
          param storageAccountName string

          var cosmosDBDatabaseName = 'FlightTests'
          var cosmosDBContainerName = 'FlightTests'
          var cosmosDBContainerPartitionKey = '/droneId'
          var logAnalyticsWorkspaceName = 'ToyLogs'
          var cosmosDBAccountDiagnosticSettingsName = 'route-logs-to-log-analytics'
          var storageAccountBlobDiagnosticSettingsName = 'route-logs-to-log-analytics'

          resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-11-15' = {
            name: cosmosDBAccountName
            location: location
            properties: {
              databaseAccountOfferType: 'Standard'
              locations: [
                {
                  locationName: location
                }
              ]
            }
          }

          resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-11-15' = {
            parent: cosmosDBAccount
            name: cosmosDBDatabaseName
            properties: {
              resource: {
                id: cosmosDBDatabaseName
              }
              options: {
                throughput: cosmosDBDatabaseThroughput
              }
            }

            resource container 'containers' = {
              name: cosmosDBContainerName
              properties: {
                resource: {
                  id: cosmosDBContainerName
                  partitionKey: {
                    kind: 'Hash'
                    paths: [
                      cosmosDBContainerPartitionKey
                    ]
                  }
                }
                options: {}
              }
            }
          }

          resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
            name: logAnalyticsWorkspaceName
          }

          resource cosmosDBAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
            scope: cosmosDBAccount
            name: cosmosDBAccountDiagnosticSettingsName
            properties: {
              workspaceId: logAnalyticsWorkspace.id
              logs: [
                {
                  category: 'DataPlaneRequests'
                  enabled: true
                }
              ]
            }
          }

          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
            name: storageAccountName

            resource blobService 'blobServices' existing = {
              name: 'default'
            }
          }

          resource storageAccountBlobDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
            scope: storageAccount::blobService
            name: storageAccountBlobDiagnosticSettingsName
            properties: {
              workspaceId: logAnalyticsWorkspace.id
              logs: [
                {
                  category: 'StorageRead'
                  enabled: true
                }
                {
                  category: 'StorageWrite'
                  enabled: true
                }
                {
                  category: 'StorageDelete'
                  enabled: true
                }
              ]
            }
          }
          ```
          
    6. Deploy the template to Azure
        ```
        az deployment group create --name main --template-file main.bicep --parameters storageAccountName={storageaccountname}
        ```

        1. Check your deployment
            1. Notice that there are two resources listed with a type of **Microsoft.Insights/diagnosticSettings**.
                - These resources are the extension resources you deployed. 
                  + One of the resources was attached to the storage account and the other was attached to the Azure Cosmos DB account.
                  + Now you can verify that the Azure Cosmos DB diagnostic settings are configured correctly.

                1. Select the Azure Cosmos DB account resource
                2. In the **Search** box in the top left, enter **Diagnostic settings**, and select the **Diagnostic settings** menu item.
                3. The Azure portal might prompt you to enable full-text query support for logging. 
                    - You don't need it for this exercise, so select **Not now**.
                4. Notice that there's a diagnostic setting named **route-logs-to-log-analytics**, which is configured to route the logs to the **ToyLogs** workspace.

8. Summary
    - Your R&D team needed a new Azure Cosmos DB database to store the data it collects when it tests the new drone it's developing.
      + The team asked you to make sure that all successful attempts to access the data are logged. 
      + The team also wanted you to log access to another storage account that it already created for storing design documents.

    - By using Bicep, you were able to create a template with child resources. 
      + You used the template to create an Azure Cosmos DB account, database, and container.
      + You used extension resources to configure the diagnostics settings for the Azure Cosmos DB account and send its logs to a Log Analytics workspace.
      + You also used the **existing** keyword so that you could add diagnostics settings to the R&D team's storage account.

    - Creating comprehensive and powerful Bicep templates requires you to understand child and extension resources.
      + Without using these features of the Bicep language, you would be limited in what you can model in your infrastructure as code templates.

9. Learn more
    - Child resources: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/child-resource-name-type
    - Extension resources: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/scope-extension-resources
    - Extension resource types: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/extension-resource-types

## Manage changes to your Bicep code by using Git
- https://learn.microsoft.com/en-us/training/modules/manage-changes-bicep-code-git
1. Understand Git
    1. What are version control and Git?
        - Version control is a practice by which you maintain a history of changes to your files.
          + Version control is also sometimes called source code management, or **SCM**.

        - Many different version control systems exist, but generally they have some core features:
          + Track the changes you make to a file.
          + View the history of a file, and go back to an older version if you need to revert a change you've made.
          + Work with multiple versions of a file at the same time.
          + Collaborate with other team members by sharing your code and changes.

        - Git is an open-source version control system. 
          + By using Git, you create repositories that maintain history and track changes. 
          + You can use different repositories for each project, or you might choose to use a single repository for all your Bicep code.

        - You use online services like GitHub and Azure Repos to work with your team on shared code. 

2. Exercise - Initialize a Git repository
    1. Install Git
    2. Configure Git
        ```Bash
        git --version

        git config --global user.name "USER_NAME"
        git config --list

        ```
    3. Create and initialize a Git repository
        ```Bash
        mkdir toy-website
        cd toy-website

        code --reuse-window .

        git init
        ```

    4. Add a Bicep file
        ```
        mkdir deploy

        ```
        - *main.bicep* file:
          ```bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string = resourceGroup().location

          @description('The type of environment. This must be nonprod or prod.')
          @allowed([
            'nonprod'
            'prod'
          ])
          param environmentType string
          ```

    5. Inspect the repository status by using the CLI
        ```
        git status
        ```

        - rename branch: `git branch -M main`

3. Commit files and view history
    1. Folder structure for your repository
        - When you work with a version control system like Git, it's important to plan how you store your files. It's a good idea to have a clear folder structure.

        - If you're building Bicep code to deploy an application or another solution, it's also a good idea to store your Bicep files in the same repository as the application code and other files. That way, anytime someone needs to add a new feature that changes both Bicep and application code, they'll be tracked together.

        - Planning your folder structure also makes it easier to deploy your solution from a pipeline. You'll learn about pipelines in a future module.

        - Different teams have different conventions for how they set up their repository folders and files. Even if you aren't working with a team, it's still a good idea to decide on a convention to follow. A good file and folder structure will help anyone who has to work with your code in future.

        - If your team doesn't already have a preference, here's a suggestion for how you might do it:

          + At the root of your repository, create a **README.md** file.
            - This text file, written in Markdown, describes the repository's contents and gives instructions to help team members work in the repository.
          + At the root of your repository, create a **deploy** folder. Inside the folder:
          + Store your main Bicep template, named **main.bicep**.
          + Create a **modules** subfolder, to store your Bicep modules.
          + If you have other scripts or files that are used during deployments, store them in the **deploy** folder.
          + At the root of your repository, create a **src** folder for source code. Use it to store application code.
          + At the root of your repository, create a **docs** folder. Use it to store documentation about your solution.
          
        - Here's an illustration of how this structure might look for your toy company's website:
          ```structured repos
          toy-website
            --> README.md
            --> deploy
                --> main.bicep
                --> modules
                    --> app-service.bicep
                    --> cosmos-db.bicep
            --> docs
                --> solution-architecture.md
            --> src
                --> index.html
          ```

    2. Stage your changes
        ```
        git add .
        git add deploy/main.bicep
        ```
    3. Commit the staged changes
        ```bash
        git commit --message "Add Cosmos DB account definition"
        ```
        - Make your commit messages short, but make them descriptive. 
          + When you or a team member reviews the commit history in the future, each commit message should explain what the change was and why you made it.

        - There aren't any rules about what commit messages need to contain or how they're formatted. 
          + But conventionally, they're written in the present tense and in a full sentence, as if you're giving orders to your codebase.

        - Here are some examples of good commit messages:
          + *Update App Service configuration to add network configuration.*
          + *Remove storage account since it's been replaced by a Cosmos DB database.*
          + *Add Application Insights resource definition and integrate with function app.*


    4. View a file's history
        ```
        git log --pretty=oneline

        git log deploy/main.bicep
        ```

4. Exercise - Commit files to your repository and view their history
    1. Commit the Bicep file by using the Git CLI
        ```
        git add deploy/main.bicep
        git commit --message "Add first version of Bicep template"
        ```

    2. Add a Bicep module
        1. add *deploy/modules/app-service.bicep* file
            ```bicep
            @description('The Azure region into which the resources should be deployed.')
            param location string

            @description('The type of environment. This must be nonprod or prod.')
            @allowed([
              'nonprod'
              'prod'
            ])
            param environmentType string

            @description('The name of the App Service app. This name must be globally unique.')
            param appServiceAppName string

            var appServicePlanName = 'toy-website-plan'
            var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'
            var appServicePlanTierName = (environmentType == 'prod') ? 'PremiumV3' : 'Free'

            resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
              name: appServicePlanName
              location: location
              sku: {
                name: appServicePlanSkuName
                tier: appServicePlanTierName
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

        2. Edit *deploy/main.bicep* file:
            ```bicep
            @description('The name of the App Service app. This name must be globally unique.')
            param appServiceAppName string = 'toyweb-${uniqueString(resourceGroup().id)}'

            module appService 'modules/app-service.bicep' = {
              name: 'app-service'
              params: {
                location: location
                environmentType: environmentType
                appServiceAppName: appServiceAppName
              }
            }
            ```

    3. Compare the differences
    4. Commit the updated Bicep code
        ```
        git commit -m 'Add App Service module'
        ```

    5. View the commit history by using the Git CLI
        ```
        git log --pretty=oneline

          --> 238b0867f533e14bcaabbade31b9d9e1bda6123b (HEAD -> main) Add App Service module
              9e41f816bf0f5c590cee88590aacc977f1361124 Add first version of Bicep template
        ```

    6. View a file's history by using Visual Studio Code
        - Right-click *main.bicep* file, select **Open Timeline**

5. Branch and merge your changes
    - When you work on Bicep code, it's common to need to do more than one thing at a time.
    - For example, here are two scenarios for working with your toy company's website:
        + Your website's development team wants your help in updating Bicep files with significant changes. 
          - However, the team doesn't want those changes to go live yet.
          - You need to be able to make minor tweaks to the current live version of the website in parallel with the work on the new version.
        
        + You're working on experimental changes that you think will help to improve the performance of the website.
          - However, these changes are preliminary.
          - You don't want to apply them to the live version of the website until you're ready.

    1. What are branches?
    2. Create and check out a branch
        - create a new branch: `git checkout -b my-experimental-changes`

        - switch to an existing branch: `git checkout main`
    3. Work on a branch
    4. Merge branches
        ```
        git checkout main
        git merge my-experimental-changes
        git branch -d my-experimental-changes
        ```

    5. Merge conflicts
    6. Git workflows
        - trunk-based development

6. Exercise - Create and merge a branch
    1. Create and check out a branch in your repository
        ```
        git checkout -b add-database
        ```

    2. Update a file on your branch
        - update *deploy/modules/cosmos-db.bicep* file
          ```bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string

          @description('The type of environment. This must be nonprod or prod.')
          @allowed([
            'nonprod'
            'prod'
          ])
          param environmentType string

          @description('The name of the Cosmos DB account. This name must be globally unique.')
          param cosmosDBAccountName string

          var cosmosDBDatabaseName = 'ProductCatalog'
          var cosmosDBDatabaseThroughput = (environmentType == 'prod') ? 1000 : 400
          var cosmosDBContainerName = 'Products'
          var cosmosDBContainerPartitionKey = '/productid'

          resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-11-15' = {
            name: cosmosDBAccountName
            location: location
            properties: {
              databaseAccountOfferType: 'Standard'
              locations: [
                {
                  locationName: location
                }
              ]
            }
          }

          resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-11-15' = {
            parent: cosmosDBAccount
            name: cosmosDBDatabaseName
            properties: {
              resource: {
                id: cosmosDBDatabaseName
              }
              options: {
                throughput: cosmosDBDatabaseThroughput
              }
            }

            resource container 'containers' = {
              name: cosmosDBContainerName
              properties: {
                resource: {
                  id: cosmosDBContainerName
                  partitionKey: {
                    kind: 'Hash'
                    paths: [
                      cosmosDBContainerPartitionKey
                    ]
                  }
                }
                options: {}
              }
            }
          }
          ```

      - update *deploy/main.bicep* file:
          ```
          @description('The name of the Cosmos DB account. This name must be globally unique.')
          param cosmosDBAccountName string = 'toyweb-${uniqueString(resourceGroup().id)}'

          module cosmosDB 'modules/cosmos-db.bicep' = {
            name: 'cosmos-db'
            params: {
              location: location
              environmentType: environmentType
              cosmosDBAccountName: cosmosDBAccountName
            }
          }
          ```

    3. Review the differences and commit the changes

7. Publish your repository to enable collaboration
    1. What are GitHub and Azure Repos?
        - Git is software that you install and run on your own computer.
          + Git keeps track of the changes you make to your files. It enables features like branching.

        - GitHub and Azure Repos are online services that keep copies of your Git repository and enable collaborative development.

    2. Local and remote repositories
        - Conventionally, the term **origin** refers to the remote repository that your local repository synchronizes with.

8. Exercise - Publish your repository
    1. Configure your local Git repository
        ```
        git checkout main

        git remote add origin YOUR_REPOSITORY_URL

        git remote -v
          --> origin https://myuser@dev.azure.com/myuser/toy-website/_git/toy-website (fetch)
              origin https://myuser@dev.azure.com/myuser/toy-website/_git/toy-website (push)
        ```

    2. Push your changes by using the Git CLI
        ```
        git push -u origin main
        ```

9. Learn more
    - The following features of Git are useful when you work with infrastructure as code:

        + **Staging your changes**, which enables you to commit only some of the things you've changed while leaving others out of the commit.
          - https://code.visualstudio.com/docs/introvideos/versioncontrol

        + **Stashing your changes**, which enables you to keep your changes without committing them.
          - https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning

        + **Undoing changes**, including reverting commits and resetting your repository status.
          - https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things

        + **Branches**, including **handling merge conflicts**, **advanced merging**, and **rebasing**.
          - Branches: https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
          - https://docs.github.com/github/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line
          - https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging
          - https://git-scm.com/book/en/v2/Git-Branching-Rebasing

        + **Branching workflows** to support your team's ways of working.
          - We introduced **trunk-based development** in this module, but some teams prefer the **GitHub Flow** model.
          - GitHub Flow: https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows
          - **Consider some best practices when selecting your branching strategy**
            + https://learn.microsoft.com/en-us/azure/devops/repos/git/git-branching-guidance

        + **Rewriting history**, including amending commit messages and removing information from your commit history, and squashing changes.
          - https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History

        + **Submodules**: https://git-scm.com/book/en/v2/Git-Tools-Submodules

## Structure your Bicep code for collaboration
- https://learn.microsoft.com/en-us/training/modules/structure-bicep-code-collaboration

1. Example scenario
    - Suppose you're an Azure infrastructure administrator at a toy company.
      + You and your team have standardized on using Bicep for your Azure deployments, and you've built a library of reusable templates.

    - Two members of the quality control team have been tasked to run a customer survey.
      + To accomplish this, they need to deploy a new website and database.
      + They're on a tight deadline, and they want to avoid building a whole new template if they don't have to.
      + After you've spoken with them about their requirements, you remember that you already have a template that's close to what they need.

    - The template is one of the first Bicep files you wrote, so you're worried that it might not be ready for them to use.
      + The question is, how can you revise the template to ensure that it's correct, easy to understand, easy to read, and easy to modify?

2. Exercise - Review your existing Bicep template
    - Take a look at the following template, which you're seeing for the first time. 
      + Do you understand what everything in the template is doing? 
      + How many issues can you find?
      + What could you do to improve the template?

      ```Bicep
      param location string = resourceGroup().location

      @allowed([
        'F1'
        'D1'
        'B1'
        'B2'
        'B3'
        'S1'
        'S2'
        'S3'
        'P1'
        'P2'
        'P3'
        'P4'
      ])
      param skuName string = 'F1'

      @minValue(1)
      param skuCapacity int = 1
      param sqlAdministratorLogin string

      @secure()
      param sqlAdministratorLoginPassword string

      param managedIdentityName string
      param roleDefinitionId string = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      param webSiteName string = 'webSite${uniqueString(resourceGroup().id)}'
      param container1Name string = 'productspecs'
      param productmanualsName string = 'productmanuals'

      var hostingPlanName = 'hostingplan${uniqueString(resourceGroup().id)}'
      var sqlserverName = 'toywebsite${uniqueString(resourceGroup().id)}'
      var storageAccountName = 'toywebsite${uniqueString(resourceGroup().id)}'

      resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
        name: storageAccountName
        location: 'eastus'
        sku: {
          name: 'Standard_LRS'
        }
        kind: 'StorageV2'
        properties: {
          accessTier: 'Hot'
        }

        resource blobServices 'blobServices' existing = {
          name: 'default'
        }
      }

      resource container1 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
        parent: storageAccount::blobServices
        name: container1Name
      }

      resource sqlserver 'Microsoft.Sql/servers@2023-08-01-preview' = {
        name: sqlserverName
        location: location
        properties: {
          administratorLogin: sqlAdministratorLogin
          administratorLoginPassword: sqlAdministratorLoginPassword
          version: '12.0'
        }
      }

      var databaseName = 'ToyCompanyWebsite'
      resource sqlserverName_databaseName 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
        name: '${sqlserver.name}/${databaseName}'
        location: location
        sku: {
          name: 'Basic'
        }
        properties: {
          collation: 'SQL_Latin1_General_CP1_CI_AS'
          maxSizeBytes: 1073741824
        }
      }

      resource sqlserverName_AllowAllAzureIPs 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
        name: '${sqlserver.name}/AllowAllAzureIPs'
        properties: {
          endIpAddress: '0.0.0.0'
          startIpAddress: '0.0.0.0'
        }
        dependsOn: [
          sqlserver
        ]
      }

      resource productmanuals 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
        name: '${storageAccount.name}/default/${productmanualsName}'
      }
      resource hostingPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
        name: hostingPlanName
        location: location
        sku: {
          name: skuName
          capacity: skuCapacity
        }
      }

      resource webSite 'Microsoft.Web/sites@2023-12-01' = {
        name: webSiteName
        location: location
        properties: {
          serverFarmId: hostingPlan.id
          siteConfig: {
            appSettings: [
              {
                name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                value: AppInsights_webSiteName.properties.InstrumentationKey
              }
              {
                name: 'StorageAccountConnectionString'
                value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
              }
            ]
          }
        }
        identity: {
          type: 'UserAssigned'
          userAssignedIdentities: {
            '${msi.id}': {}
          }
        }
      }

      // We don't need this anymore. We use a managed identity to access the database instead.
      //resource webSiteConnectionStrings 'Microsoft.Web/sites/config@2020-06-01' = {
      //  name: '${webSite.name}/connectionstrings'
      //  properties: {
      //    DefaultConnection: {
      //      value: 'Data Source=tcp:${sqlserver.properties.fullyQualifiedDomainName},1433;Initial Catalog=${databaseName};User Id=${sqlAdministratorLogin}@${sqlserver.properties.fullyQualifiedDomainName};Password=${sqlAdministratorLoginPassword};'
      //      type: 'SQLAzure'
      //    }
      //  }
      //}

      resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
        name: managedIdentityName
        location: location
      }

      resource roleassignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
        name: guid(roleDefinitionId, resourceGroup().id)

        properties: {
          principalType: 'ServicePrincipal'
          roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
          principalId: msi.properties.principalId
        }
      }

      resource AppInsights_webSiteName 'Microsoft.Insights/components@2020-02-02' = {
        name: 'AppInsights'
        location: location
        kind: 'web'
        properties: {
          Application_Type: 'web'
        }
      }
      ```

    1. Create and save the Bicep file
        - you'll make changes that improve the template. 
          + You'll follow best practices to make it easier to read and understand, and easier for your colleagues to work with.

        - IMPORTANT: The process of improving code by reorganizing and renaming it is called **refactoring**.
          + When you refactor code, it's a good idea to use a version-control system such as Git.
          + With version control, you can make changes to your code, undo those changes, or return to a previous version.

3. Improve parameters and names
    - Parameters are the most common way that your colleagues will interact with your template. 
      + When they deploy your template, they need to specify values for the parameters.
      + After it's created, a resource's name provides important information about its purpose to anyone who looks at your Azure environment.

    1. How understandable are the parameters?
        - For example, suppose you need to deploy a storage account by using a Bicep file.
          + One of the required properties of the storage account is the stock keeping unit (SKU), which defines the level of data redundancy.
          + The SKU has several properties, the most important being **name**.
          + When you create a parameter to set the value for the storage account's SKU, use a clearly defined name, such as **storageAccountSkuName**. 
          + Using this value instead of a generic name like **sku** or **skuName** will help others understand the purpose of the parameter and the effects of setting its value.

        - Default values are an important way to make your template usable by others.
          + It's important to use default values where they make sense.
          + They help your template's users in two ways:
            - Default values simplify the process of deploying your template. 
            - Default values provide an example of how you expect the parameter value to look.

        - Bicep can also help to validate the input that users provide through **parameter decorators**.
        - Bicep provides several types of parameter decorators:
          + **Descriptions**: provide human-readable information about the purpose of the parameter and the effects of setting its value.

          + **Value constraints**: enforce limits on what users can enter for the parameter's value.
            - *@allowed()*, *@minValue()* and *@maxValue()*, *@minLength()* and *@maxLength()*
            - TIP: Be careful when you use the *@allowed()* parameter decorator to specify SKUs.
              + Azure services often add new SKUs, and you don't want your template to unnecessarily prohibit their use.
              + Consider using Azure Policy to enforce the use of specific SKUs, and use the *@allowed()* decorator with SKUs only when there are functional reasons why your template's users shouldn't select a specific SKU.
                - For example, the features that your template needs might not be available in that SKU.
                - Explain this by using a *@description()* decorator or comment that makes the reasons clear to anyone in future.

          + **Metadata**: although not commonly used, can be applied to provide extra custom metadata about the parameter.

    2. How flexible should a Bicep file be?
        - One of the goals of defining your infrastructure as code is to make your templates reusable and flexible. 
        - When you're planning a template, consider how you'll balance flexibility with simplicity.
        - There are two common ways to provide parameters in templates:
          + Provide free-form configuration options
          + Use predefined configuration sets

        - Let's consider both approaches by using an example Bicep file that deploys a storage account and an Azure App Service plan.
          1. Provide free-form configuration options
              - Both the App Service plan and the storage account require that you specify their SKUs.
              - You might consider creating a set of parameters to control each of the SKUs and instance counts for the resources:
                ```Bicep
                param appServicePlanSkuName string
                param appServicePlanSkuCapacity int
                param storageAccountSkuName string

                resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
                  name: appServicePlanName
                  location: location
                  sku: {
                    name: appServicePlanSkuName
                    capacity: appServicePlanSkuCapacity
                  }
                }

                resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
                  name: storageAccountSkuName
                  location: location
                  sku: {
                    name: storageAccountSkuName
                  }
                }
                ```

          2. Use predefined configuration sets
              - Alternatively, you could provide a **configuration set**: a single parameter, whose value is a restricted list of allowed values, such as a list of environment types.
                + When users deploy your template, they need to select a value for only this one parameter.
                + When they select a value for the parameter, the deployment automatically inherits a set of configuration:
                ```bicep
                @allowed([
                  'Production'
                  'Test'
                ])
                param environmentType string = 'Test'

                // create a map variable to define the specific properties to set on various resources
                var environmentConfigurationMap = {
                  Production: {
                    appServicePlan: {
                      sku: {
                        name: 'P2V3'
                        capacity: 3
                      }
                    }
                    storageAccount: {
                      sku: {
                        name: 'ZRS'
                      }
                    }
                  }
                  Test: {
                    appServicePlan: {
                      sku: {
                        name: 'S2'
                        capacity: 1
                      }
                    }
                    storageAccount: {
                      sku: {
                        name: 'LRS'
                      }
                    }
                  }
                }
                ```

                ```bicep
                resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
                  name: appServicePlanName
                  location: location
                  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
                }
                ```

    3. How are your resources named?
        1. Symbolic names
            - are used only within the Bicep file and don't appear on your Azure resources. 
        2. Resource names
            - are the names of the resources that are created in Azure.
            - Many resources have constraints on their names, and many require their names to be unique.
            - Important: You can't rename resources after they're deployed.
            -  Cloud Adoption Framework for Azure has specific guidance:
              + https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging
            -  every Azure resource has certain naming **rules and restrictions**
              + https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules

            - TIP: It's better to use uniqueness suffixes rather than prefixes.
              + This approach makes it easier to sort and to quickly scan your resource names. 
              + Also, some Azure resources have restrictions about the first character of the name, and randomly generated names can sometimes violate these restrictions.

            - NOTE: Not every resource requires a globally unique name. 
              + Consider whether you include the uniqueness suffix in the names of every resource or just those that need it.

4. Plan the structure of your Bicep file
    1. What order should your Bicep code follow?
        - There are two main approaches to ordering your code:
          + Group elements by element type
          + Group elements by resource
        
        1. Group elements by element type
            - You can group all elements of the same type together. 
            - All your parameters would go in one place, usually at the top of the file.
            - Variables come next, followed by resources and modules, and outputs are at the bottom. 

        2. Group elements by resource
            - Alternatively, you can group your elements based on the type of resources you're deploying.
              + Continuing the preceding example, you could group all the parameters, variables, resources, and outputs that relate to the Azure SQL database resources.
              + You could then add the parameters, variables, resources, and outputs for the storage account

    2. How can white space help create structure?
        - Blank lines, or white space, can help you add visual structure to your template.
        - consider adding a blank line between major sections.

    3. How do you define several similar resources?
        - you can use loops to deploy similar resources from a single definition by using **for** keyword.
          ```bicep
          var cosmosDBContainerDefinitions = [
            {
              name: 'customers'
              partitionKey: '/customerId'
            }
            {
              name: 'orders'
              partitionKey: '/orderId'
            }
            {
              name: 'products'
              partitionKey: '/productId'
            }
          ]

          resource cosmosDBContainers 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = [for cosmosDBContainerDefinition in cosmosDBContainerDefinitions: {
            parent: cosmosDBDatabase
            name: cosmosDBContainerDefinition.name
            properties: {
              resource: {
                id: cosmosDBContainerDefinition.name
                partitionKey: {
                  kind: 'Hash'
                  paths: [
                    cosmosDBContainerDefinition.partitionKey
                  ]
                }
              }
              options: {}
            }
          }]
          ```
    
    4. How do you deploy resources only to certain environments?
        - use **if** keyword:
          ```bicep
          var environmentConfigurationMap = {
            Production: {
              enableLogging: true
            }
            Test: {
              enableLogging: false
            }
          }

          resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = if (environmentConfigurationMap[environmentType].enableLogging) {
            name: logAnalyticsWorkspaceName
            location: location
          }

          resource cosmosDBAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (environmentConfigurationMap[environmentType].enableLogging) {
            scope: cosmosDBAccount
            name: cosmosDBAccountDiagnosticSettingsName
            properties: {
              workspaceId: logAnalyticsWorkspace.id
              // ...
            }
          }
          ```

    5. How do you express dependencies between your resources?
        - use **dependsOn** property
        - use the symbolic name of one resource within a property of another.
    
    6. How do you express parent-child relationships?
        - For example, an Azure SQL database is a child of a SQL server instance.
        - use **parent** property

    7. How do you set resource properties?
        - consider defining resource properties as parameters or variables to make your Bicep code more dynamic and reusable.
        - TIP: When creating outputs, try to use resource properties wherever you can.
          + Avoid incorporating your own assumptions about how resources work, because these assumptions might change over time.

    8. How do you use version control effectively?
        - Git

5. Document your code by adding comments and metadata
    - Good Bicep code is **self-documenting**. 
      + This means that it uses clear naming and a good structure so that when colleagues read your code, they can quickly understand what's happening.

    1. Add comments to your code
        - Single-line comments: *//*
        - Multi-line comments: __/* ... */__ characters

        - You can also use Bicep comments to add a structured multi-line block at the beginning of each file.
          + Think of it as a manifest. 
          + Your team might decide that each template and module should have a manifest that describes the purpose of the template and what it contains, such as in this example:
            ```Bicep
            /*
              SYNOPSIS: Module for provisioning Azure SQL server and database.
              DESCRIPTION: This module provisions an Azure SQL server and a database, and configures the server to accept connections from within Azure.
              VERSION: 1.0.0
              OWNER TEAM: Website
            */
            ```

    2. Add comments to parameter files
        - use **.JSONC** instead of **.JSON** file
          ```JSONC
          {
            "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
              "productStockCheckApiUrl": {
                "value": "https://x73.mytoycompany.com/e4/j7" // This is the URL to the product stock API in the development environment.
              }
            }
          }
          ```

    3. Add descriptions to parameters, variables, and outputs
        ```Bicep
        @description('The Azure region into which the resources should be deployed.')
        param location string = resourceGroup().location

        @description('Indicates whether the web application firewall policy should be enabled.')
        var enableWafPolicy = (environmentType == 'prod')

        @description('The default host name of the App Service app.')
        output hostName string = app.properties.defaultHostName
        ```

        - Descriptions are more powerful than comments because they are shown whenever someone hovers over a symbolic name.

    4. Add descriptions to resources
        - apply the **@description()** decorator to resources.
        - For example, many Azure Policy resources and Azure role-based access control (RBAC) role assignments include a description property.
            ```Bicep
            resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
              scope: storageAccount
              name: guid(roleDefinitionId, resourceGroup().id)
              properties: {
                principalType: 'ServicePrincipal'
                roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
                principalId: principalId
                description: 'Contributor access on the storage account is required to enable the application to create blob containers and upload blobs.'
              }
            }
            ```

    5. Apply resource tags
        - there are many situations where you need to track information about your deployed Azure resources, including:
          + Allocating your Azure costs to specific cost centers.
          + Understanding how the data that's contained in databases and storage accounts should be classified and protected.
          + Recording the name of the team or person who's responsible for management of the resource.
          + Tracking the name of the environment that the resource relates to, such as production or development.

        - **Resource tags** allow you to store important metadata about resources.
            ```bicep
            resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
              name: storageAccountName
              location: location

              // HIGHLIGHT
              tags: {
                CostCenter: 'Marketing'
                DataClassification: 'Public'
                Owner: 'WebsiteTeam'
                Environment: 'Production'
              }
              sku: {
                name: storageAccountSkuName
              }
              kind: 'StorageV2'
              properties: {
                accessTier: 'Hot'
              }
            }
            ```

        - It's common to use the same set of tags for all your resources, so it's often a good idea to define your tags as parameters or variables
          ```Bicep
          param tags object = {
            CostCenter: 'Marketing'
            DataClassification: 'Public'
            Owner: 'WebsiteTeam'
            Environment: 'Production'
          }

          resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
            tags: tags
          }

          resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
            tags: tags
          }
          ```

6. Exercise - Refactor your Bicep file
    1. Update the parameters
        - TIP: VSCode, use **Find All References** and **F2** to rename.
        - *skuName* and  *skuCapacity* params are not clear.
        - *managedIdentityName* parameter doesn't have a default value.

    2. Add a configuration set
        - use specific SKUs for each resource, depending on the environment being deployed.
          ```
          Resource	        SKU for production	  SKU for non-production
          App Service plan	S1, two instances	    F1, one instance
          Storage account	  GRS	                  LRS
          SQL database	    S1	                  Basic
          ```

    3. Update the symbolic names
        1. a variety of capitalization styles for their symbolic names
            - *storageAccount* and *webSite*, which use camelCase capitalization.
            - *roleassignment* and *sqlserver*, which use flat case capitalization.
            - *sqlserverName_databaseName* and *AppInsights_webSiteName*, which use snake case capitalization.

        2. Look at this role assignment resource: *roleassignment*
            - Is the symbolic name descriptive enough?
            - The reason the identity needs a role assignment is that the web app uses its managed identity to connect to the database server.

        3. A few resources have symbolic names that don't reflect the current names of Azure resources:
            - *hostingPlan*, *webSite*, *msi*

    4. Simplify the blob container definitions
        1. Look at how the blob containers are defined:
            ```bicep
            resource container1 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
              parent: storageAccount::blobServices
              name: container1Name
            }

            resource productmanuals 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
              name: '${storageAccount.name}/default/${productmanualsName}'
            }
            ```
            - One of them uses the parent property, and the other doesn't. Can you fix these to be consistent?

        2. The blob container names won't change between environments. Do you think the names need to be specified by using parameters?
        3. There are two blob containers. Could they be deployed by using a loop?

    4. Update the resource names
        1. There are some parameters that explicitly set resource names:
            ```Bicep
            param managedIdentityName string
            param roleDefinitionId string = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
            param webSiteName string = 'webSite${uniqueString(resourceGroup().id)}'
            param container1Name string = 'productspecs'
            param productmanualsName string = 'productmanuals'
            ```
            - Is there another way you could do this?
            - CAUTION: Remember that resources can't be renamed once they're deployed.

        2. Your SQL logical server's resource name is set using a variable, even though it needs a globally unique name:
            ```bicep
            var sqlserverName = 'toywebsite${uniqueString(resourceGroup().id)}'
            ```

    5. Update dependencies and child resources
        ```bicep
        resource sqlserverName_databaseName 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
          // LOOK
          name: '${sqlserver.name}/${databaseName}'
          location: location
          sku: {
            name: 'Basic'
          }
          properties: {
            collation: 'SQL_Latin1_General_CP1_CI_AS'
            maxSizeBytes: 1073741824
          }
        }

        resource sqlserverName_AllowAllAzureIPs 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
          name: '${sqlserver.name}/AllowAllAzureIPs'
          properties: {
            endIpAddress: '0.0.0.0'
            startIpAddress: '0.0.0.0'
          }
          // LOOK
          dependsOn: [
            sqlserver
          ]
        }
        ```

    6. Update property values
        1. Take a look at the SQL database resource properties:
            ```bicep
            resource sqlserverName_databaseName 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
              name: '${sqlserver.name}/${databaseName}'
              location: location
              sku: {
                name: 'Basic'
              }
              properties: {
                collation: 'SQL_Latin1_General_CP1_CI_AS'
                maxSizeBytes: 1073741824
              }
            }
            ```
            - Does it make sense to hard-code the SKU's name property value?
              + And what are those weird-looking values for the collation and maxSizeBytes properties?
            - TIP: The collation and maxSizeBytes properties are set to the default values. 
              + If you don't specify the values yourself, the default values will be used. Does that help you to decide what to do with them?

        2. Can you change the way the storage connection string is set so that the complex expression isn't defined inline with the resource?
            ```bicep
            resource webSite 'Microsoft.Web/sites@2023-12-01' = {
              name: webSiteName
              location: location
              properties: {
                serverFarmId: hostingPlan.id
                siteConfig: {
                  appSettings: [
                    {
                      name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                      value: AppInsights_webSiteName.properties.InstrumentationKey
                    }
                    {
                      name: 'StorageAccountConnectionString'

                      // HIGHTLIGT
                      value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
                    }
                  ]
                }
              }
              identity: {
                type: 'UserAssigned'
                userAssignedIdentities: {
                  '${msi.id}': {}
                }
              }
            }
            ```
    
    7. Order of elements
        1. Are you happy with the order of the elements in the file? 
            - How could you improve the file's readability by moving the elements around?
        2. Take a look at the **databaseName** variable. Does it belong where it is now?
            ```Bicep
            //NOTICE
            var databaseName = 'ToyCompanyWebsite'
            resource sqlserverName_databaseName 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
              name: '${sqlserver.name}/${databaseName}'
              location: location
              sku: {
                name: 'Basic'
              }
              properties: {
                collation: 'SQL_Latin1_General_CP1_CI_AS'
                maxSizeBytes: 1073741824
              }
            }
            ```

        3. Did you notice the commented-out resource, **webSiteConnectionStrings**? Do you think that needs to be in the file?


    8. Add comments, tags, and other metadata
        1. Take a look at the **webSite** resource's **identity** property:
            ```Bicep
            resource webSite 'Microsoft.Web/sites@2023-12-01' = {
              name: webSiteName
              location: location
              properties: {
                serverFarmId: hostingPlan.id
                siteConfig: {
                  appSettings: [
                    {
                      name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                      value: AppInsights_webSiteName.properties.InstrumentationKey
                    }
                    {
                      name: 'StorageAccountConnectionString'
                      value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
                    }
                  ]
                }
              }
              identity: {
                type: 'UserAssigned'
                userAssignedIdentities: {
                  '${msi.id}': {}
                }
              }
            }
            ```
            - That syntax is strange, isn't it? Do you think this needs a comment to help explain it?

        2. Look at the role assignment resource:
            ```Bicep
            resource roleassignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
              name: guid(roleDefinitionId, resourceGroup().id)

              properties: {
                principalType: 'ServicePrincipal'
                roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
                principalId: msi.properties.principalId
              }
            }
            ```
            - The resource name uses the **guid()** function. Would it help to explain why?

        3. Can you add a description to the role assignment?
        4. Can you add a set of tags to each resource?

    9. Suggested solution
        - Here's an example of how you might refactor the template. Your template might not look exactly like this, because your style might be different.

        ```Bicep
        @description('The location into which your Azure resources should be deployed.')
        param location string = resourceGroup().location

        @description('Select the type of environment you want to provision. Allowed values are Production and Test.')
        @allowed([
          'Production'
          'Test'
        ])
        param environmentType string

        @description('A unique suffix to add to resource names that need to be globally unique.')
        @maxLength(13)
        param resourceNameSuffix string = uniqueString(resourceGroup().id)

        @description('The administrator login username for the SQL server.')
        param sqlServerAdministratorLogin string

        @secure()
        @description('The administrator login password for the SQL server.')
        param sqlServerAdministratorLoginPassword string

        @description('The tags to apply to each resource.')
        param tags object = {
          CostCenter: 'Marketing'
          DataClassification: 'Public'
          Owner: 'WebsiteTeam'
          Environment: 'Production'
        }

        // Define the names for resources.
        var appServiceAppName = 'webSite${resourceNameSuffix}'
        var appServicePlanName = 'AppServicePLan'
        var sqlServerName = 'sqlserver${resourceNameSuffix}'
        var sqlDatabaseName = 'ToyCompanyWebsite'
        var managedIdentityName = 'WebSite'
        var applicationInsightsName = 'AppInsights'
        var storageAccountName = 'toywebsite${resourceNameSuffix}'
        var blobContainerNames = [
          'productspecs'
          'productmanuals'
        ]

        @description('Define the SKUs for each component based on the environment type.')
        var environmentConfigurationMap = {
          Production: {
            appServicePlan: {
              sku: {
                name: 'S1'
                capacity: 2
              }
            }
            storageAccount: {
              sku: {
                name: 'Standard_GRS'
              }
            }
            sqlDatabase: {
              sku: {
                name: 'S1'
                tier: 'Standard'
              }
            }
          }
          Test: {
            appServicePlan: {
              sku: {
                name: 'F1'
                capacity: 1
              }
            }
            storageAccount: {
              sku: {
                name: 'Standard_LRS'
              }
            }
            sqlDatabase: {
              sku: {
                name: 'Basic'
              }
            }
          }
        }

        @description('The role definition ID of the built-in Azure \'Contributor\' role.')
        var contributorRoleDefinitionId = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
        var storageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'

        resource sqlServer 'Microsoft.Sql/servers@2023-08-01-preview' = {
          name: sqlServerName
          location: location
          tags: tags
          properties: {
            administratorLogin: sqlServerAdministratorLogin
            administratorLoginPassword: sqlServerAdministratorLoginPassword
            version: '12.0'
          }
        }

        resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
          parent: sqlServer
          name: sqlDatabaseName
          location: location
          sku: environmentConfigurationMap[environmentType].sqlDatabase.sku
          tags: tags
        }

        resource sqlFirewallRuleAllowAllAzureIPs 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
          parent: sqlServer
          name: 'AllowAllAzureIPs'
          properties: {
            endIpAddress: '0.0.0.0'
            startIpAddress: '0.0.0.0'
          }
        }

        resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
          name: appServicePlanName
          location: location
          sku: environmentConfigurationMap[environmentType].appServicePlan.sku
          tags: tags
        }

        resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
          name: appServiceAppName
          location: location
          tags: tags
          properties: {
            serverFarmId: appServicePlan.id
            siteConfig: {
              appSettings: [
                {
                  name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                  value: applicationInsights.properties.InstrumentationKey
                }
                {
                  name: 'StorageAccountConnectionString'
                  value: storageAccountConnectionString
                }
              ]
            }
          }
          identity: {
            type: 'UserAssigned'
            userAssignedIdentities: {
              '${managedIdentity.id}': {} // This format is required when working with user-assigned managed identities.
            }
          }
        }

        resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
          name: storageAccountName
          location: location
          sku: environmentConfigurationMap[environmentType].storageAccount.sku
          kind: 'StorageV2'
          properties: {
            accessTier: 'Hot'
          }

          resource blobServices 'blobServices' existing = {
            name: 'default'

            resource containers 'containers' = [for blobContainerName in blobContainerNames: {
              name: blobContainerName
            }]
          }
        }

        @description('A user-assigned managed identity that is used by the App Service app to communicate with a storage account.')
        resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview'= {
          name: managedIdentityName
          location: location
          tags: tags
        }

        @description('Grant the \'Contributor\' role to the user-assigned managed identity, at the scope of the resource group.')
        resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
          name: guid(contributorRoleDefinitionId, resourceGroup().id) // Create a GUID based on the role definition ID and scope (resource group ID). This will return the same GUID every time the template is deployed to the same resource group.
          properties: {
            principalType: 'ServicePrincipal'
            roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', contributorRoleDefinitionId)
            principalId: managedIdentity.properties.principalId
            description: 'Grant the "Contributor" role to the user-assigned managed identity so it can access the storage account.'
          }
        }

        resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
          name: applicationInsightsName
          location: location
          kind: 'web'
          tags: tags
          properties: {
            Application_Type: 'web'
          }
        }
        ```

7. Summary
    - As you continue to use Bicep, you'll benefit from understanding the **Bicep patterns**. 
      + The patterns provide proven solutions to some of the common scenarios Bicep users face.
      + Bicep patterns: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/patterns-configuration-set

    - You should also be familiar with **Bicep scenarios**, which provide guidance on how to build Bicep files for specific types of Azure resources.
      + Bicep scenarios: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/scenarios-rbac

8. References
    - Best practices for Bicep: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices
    - Cloud Adoption Framework guidance on naming and tagging
      + https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging
    - Azure resource name rules: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules

## Review Azure infrastructure changes by using Bicep and pull requests

## Preview Azure deployment changes by using what-if
- https://learn.microsoft.com/en-us/training/modules/arm-template-whatif/

1. Introduction
    - Deployments that use Azure Resource Manager templates (ARM templates) and Bicep files result in a series of changes to your Azure environment. 
      + In this module, you learn how to preview changes before you execute a deployment.

2. Example scenario
    - Suppose you help to manage the Azure environment at a toy company.
      + One of your colleagues has asked you to help update some templates that you previously created to deploy a virtual network.
      + Before you deploy your updated template, you want to confirm exactly what changes Azure will make. 
      + So you decide to evaluate how to preview changes in your deployments.

2. Understand deployment modes
    - Azure Resource Manager supports two deployment modes: incremental and complete.
    1. Incremental mode
        - The default deployment mode is incremental. 
          + In this mode, Resource Manager doesn't delete anything. 
          + If resources exist in the resource group but aren't specified in the template, Resource Manager leaves them alone.
          + Resources in the template are added to the resource group if they don't already exist, and if they do exist, Resource Manager updates them to the configuration in the template.

    2. Complete mode
        - You have to explicitly ask for your deployment to run in complete mode. 
          + When you use this mode, resources that exist in Azure but that aren't specified in the template are deleted. 
          + Complete mode doesn't delete all resources in your resource group

        - CAUTION: When you run the command in complete mode, whatever resources you have will be removed if they're not defined in the template file.

        - In Bicep, you can refer to an existing resource by using the existing keyword.
          + Referring to a resource in this way doesn't stop it from being deleted during a deployment in complete mode.

        1. When should I use complete mode?
            - It might seem like a strange idea to allow Azure to delete your resources like this. 
              + However, there's a good reason why you might want to consider it.
              + If all of your infrastructure is defined in templates, then using complete mode every time you deploy ensures that no errant resources are left afterward.
              + In other words, it helps to avoid configuration drift in your environment.

            - If you know with certainty that what's in the template file constitutes the full state of your deployment, then go ahead and use this mode.
              + If you use tools like the Azure CLI or PowerShell to update your state gradually, then incremental mode is the way to go.

    3. Deployment scopes
        - Complete mode is available when you deploy to a resource group. 
          + If you use templates to deploy resources to a subscription, management group, or a tenant, you aren't able to use complete mode.

3. Predict what a deployment will do by using what-if
    - Anyone who's deploying or modifying resources in an environment has questions like these on their mind:
      + Will I break something?
      + Am I going to delete anything?
      + How will this deployment affect existing resources?
      + Can I validate that what I expect to happen is actually what will happen in the deployment, before I hit the deploy button?

    1. Control the format of what-if results
        ```Azure CLI
        az deployment group what-if --resource-group ToyStorage --template-file $templateFile --result-format FullResourcePayloads
        ```
        - **FullResourcePayloads**: get a verbose output that consists of a list of resources that will change.
        - **ResourceIdOnly**: returns a list of resources that will change, but not all the details

    2. Types of changes that what-if detects
        - When you use the what-if operation, it lists six types of changes:
          + Create:	The resource doesn't currently exist but is defined in the template.
          + Delete:	This change type applies only when you're using complete mode for deployment. The resource exists but isn't defined in the template.
            - If you deploy by using incremental mode, the resource isn't deleted.
            - If you deploy by using complete mode, the resource is deleted
          + Ignore:	The resource exists but isn't defined in the template.
            - When you use incremental mode, which is the default deployment mode, the resource isn't deployed or modified.
            - If you deploy by using complete mode, the resource will be deleted.
          + NoChange:	The resource exists and is defined in the template.
            - The resource will be redeployed, but the properties of the resource won't change.
          + Modify:	The resource exists and is defined in the template.
            - The resource will be redeployed, and the properties of the resource will change.
          + Deploy:	The resource exists and is defined in the template.
            - The resource will be redeployed.

        1. Use what-if results in a script
            - You might want to use the output from the what-if operation within a script or as part of an automated deployment process.
            - You can get the raw JSON results by appending the **--no-pretty-print** argument to your CLI command.
              + Then, your script can parse the results and perform any custom logic you might need.

    3. Deployment modes and deletion of resources
    4. Confirm your deployments
        - use the __--confirm-with-what-if__ argument

        - TIP: It's a good idea to run your deployment commands with the **--confirm-with-what-if** argument, especially if you're deploying in complete mode. 
          + If you use the **--confirm-with-what-if** switch, you have a chance to stop the operation if you don't like the proposed changes.

4. Exercise - Preview changes with the what-if command
    1. Create the starting template
        - **main.bicep** file:
          ```bicep
          param location string  = resourceGroup().location

          resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
            name: 'vnet-001'
            location: location
            tags: {
              CostCenter: '12345'
              Owner: 'Team A'
            }
            properties: {
              addressSpace: {
                addressPrefixes: [
                  '10.0.0.0/16'
                ]
              }
              enableVmProtection: false
              enableDdosProtection: false
              subnets: [
                {
                  name: 'subnet001'
                  properties: {
                    addressPrefix: '10.0.0.0/24'
                  }
                }
                {
                  name: 'subnet002'
                  properties: {
                    addressPrefix: '10.0.1.0/24'
                  }
                }
              ]
            }
          }
          ```

    2. Deploy the template to Azure
        ```Azure CLI
        az deployment group create --name main --template-file main.bicep
        ```
    
    3. Verify the deployment
        - *vnet-001*: virtual network

    4. Modify the template
        - delete the tag named **Owner** and its value
          ```bicep
          tags: {
            CostCenter: '12345'
          }
          ```
        - Update the **addressPrefixes** to change the **/16** to **/15**
          ```
          addressSpace: {
            addressPrefixes: [
              '10.0.0.0/15'
            ]
          }
          ```

        - Delete the subnet named **subnet001**
          ```bicep
          subnets: [
            {
              name: 'subnet002'
              properties: {
                addressPrefix: '10.0.1.0/24'
              }
            }
          ]
          ```

    5. Run the **what-if** command with the modified template
        ```Azure CLI
        az deployment group what-if --template-file main.bicep
        ```

    6. Remove the resources in the template
        - delete all of the contents of the *main.bicep*

    7. Deploy by using **complete mode** and the confirmation option
        - WARNING: Doing this in real life will remove anything you have in the cloud. The following code is interesting as an intellectual experiment, but be careful about using this mode.
          + At minimum, use the **--confirm-with-what-if** flag so you can stop this operation if you don't like the proposed changes.

        - Step 1. Run **az deployment group create** with the flag **--mode Complete** to create a deployment in complete mode:
        ```Azure CLI
        az deployment group create --name main --mode Complete --confirm-with-what-if --template-file main.bicep
        ```
        
        - Step 2. Enter **y** (for "yes") to execute the deployment and clean out your environment.

    8. Verify the deployment

5. Summary

## Migrate Azure resources and JSON ARM templates to use Bicep

# Option 1: Deploy Azure resources by using Bicep and Azure Pipelines
- https://learn.microsoft.com/en-us/training/paths/bicep-azure-pipelines/

## Build your first Bicep deployment pipeline by using Azure Pipelines
- https://learn.microsoft.com/en-us/training/modules/build-first-bicep-deployment-pipeline-using-azure-pipelines/

1. Introduction
    1. Example scenario
    2. What is the main goal?
        - use Azure Pipelines to create a pipeline that deploys a basic Bicep file to an Azure resource group.

2. Understand Azure Pipelines
    - Azure Pipelines is a feature of the Azure DevOps service. 
      + Azure DevOps also includes Azure Repos, which hosts the Git repositories you use to store and share your code with your collaborators.
      + When you store your Bicep code in Git, Azure Pipelines can access your code to automate your deployment processes.

    1. What is a pipeline?
        - A pipeline is the repeatable process that you use to test and deploy your code defined in a configuration file.
          + A pipeline includes all the steps you want to execute and in what order.

    2. Agents and pools
        - An **agent** is a computer that's configured to run deployment steps for a pipeline.
          + The agents sometimes are called Microsoft-hosted agents or hosted agents because they're hosted on your behalf
          + When your pipeline runs, a hosted agent is automatically created. 
            - When your pipeline is finished running, the hosted agent is automatically deleted. 
            - You can't access hosted agents directly, so it's important that your pipeline contains all the steps necessary to deploy your solution.

        - An **agent pool** contains multiple agents of the same type.
          + When you create your pipeline, you tell Azure Pipelines which agent pool to use to execute each set of steps. 
          + When your pipeline runs, it waits for an agent from the pool to become available, and then it instructs the agent to run your deployment steps.

        - NOTE: You have the option to create a custom agent that's called a self-hosted agent.
          + You might create a **self-hosted agent** if you have specific software that you need to run as part of your pipeline or if you need to control precisely how the agent is configured.

    3. Triggers
        - To instruct Azure Pipelines when to run your pipeline, you create a trigger.

    4. Steps
        - A **step** represents a single operation that the pipeline performs. 
          + A step is similar to an individual command that you run in Bash or PowerShell. 
          + For most deployments, you execute several steps in a sequence. 
          + You define the sequence and all the details of each step in your pipeline YAML file.

        - Azure Pipelines offers two types of steps:
          + 1. Scripts: 
            - Use a script step to run a single command or a sequence of commands in Bash, PowerShell, or the Windows command shell.

          + 2. Tasks
            - A task is a convenient way to access many different capabilities without writing script statements. 
            - For example, a built-in task can run the Azure CLI and Azure PowerShell cmdlets to test your code or upload files to an FTP server.
              + Anyone can write a task and share it with other users by publishing the task in the Visual Studio Marketplace. 
              + A large set of commercial and open-source tasks are available.

    5. Jobs
        - In Azure Pipelines, a job represents an ordered set of steps. 
          + You always have at least one job in a pipeline, and when you create complex deployments, it's common to have more than one job.

        - NOTE: You can set each job to run on a different agent pool. 
          + Running jobs on different agent pools is useful when you build and deploy solutions that need to use different operating systems in different parts of the job pipeline.

          + For example, suppose you're building an iOS app and the app's back-end service.
            - You might have one job that runs on a macOS agent pool to build the iOS app and another job that runs on an Ubuntu or Windows agent pool to build the back end. 
            - You might even tell the pipeline to run the two jobs simultaneously, which speeds up your pipeline's execution.

        - NOTE: You also can use **stages** in Azure Pipelines to divide your pipeline into logical phases and add manual checks at various points in your pipeline's execution. 

    6. Basic pipeline example
        ```yaml
        trigger: none

        pool:
          vmImage: ubuntu-latest

        jobs:
        - job:
          steps:
          - script: echo Hello, world!
            displayName: 'Run a one-line script'
          
          - script: |
              echo We'll add more steps soon.
              echo For example, we'll add our Bicep deployment step.
            displayName: 'Run a multi-line script'
        ```
        - **trigger**: tells your pipeline when to execute. 
          + In this case, trigger: none tells Azure Pipelines that you want to manually trigger the pipeline.
        
        - **pool**: instructs the pipeline which agent pool to use when it runs the pipeline steps. 
          + In this example, the pipeline runs on an agent running the Ubuntu operating system, which comes from the pool of Microsoft-hosted agents.

        - **jobs**: groups together all the jobs in your pipeline.
        - **job**: tells your pipeline that you have a single job.
          + TIP: When you have only one job in your pipeline, you can omit the **jobs** and **job** keywords.

        - **steps**: lists the sequence of actions to run in the job.
          + To create a multi-line script step, use the pipe character (**|**) as shown in the example

3. Exercise - Create and run a basic pipeline
    1. Create a project in Azure DevOps
        - Go to dev.azure.com, create a project:
          + Project name: *toy-website*
          + Description: *Toy company website*
          + Visibility: create public and private repositories. 
            - You can grant access to other users later.

    2. Clone the repository
    3. Install the Azure Pipelines extension: *Azure Pipelines*
    4. Create a YAML pipeline definition
        1. From *TOY-WEBSITE* project, create *deploy/azure-pipelines.yml*
            ```yaml
            trigger: none

            pool:
              vmImage: ubuntu-latest

            jobs:
            - job:
              steps:
              - script: echo Hello world!
                displayName: 'Placeholder step'
            ```
        2. Commit the changes
            ```
            git add deploy/azure-pipelines.yml
            git commit -m "Add initial pipeline definition"
            git push
            ```

    5. Set up the pipeline in Azure Pipelines
        1. In the resource menu of your Azure DevOps session, select **Pipelines**, and in the **Create your first Pipeline** pane, select **Create Pipeline**.
        2. On the **Connect** tab's **Where is your code?** pane, select **Azure Repos Git**.
        3. On the **Select** tab's **Select a repository** pane, select **toy-website**
        4. On the **Configure** tab's **Configure your pipeline** pane, select **Existing Azure Pipelines YAML file**.
        5. On the **Select an existing YAML file** pane's **Path** dropdown, select **/deploy/azure-pipelines.yml**, and then select **Continue**.
            - TIP: The Azure Pipelines web interface provides an editor that you can use to manage your pipeline definition. 
              + In this module, you work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works.
        
        6. select **Run**

    6. Verify the pipeline run
        - IMPORTANT: 
          + If this is your first time using pipelines in this Azure DevOps organization, you might see an error saying:
            ```
            No hosted parallelism has been purchased or granted.
            ```

          + To request that your Azure DevOps organization be granted access to free pipeline agents, complete this form.
            - https://aka.ms/azpipelines-parallelism-request

        1. Select the **Checkout toy-website@main to s**.
            - the repository's contents were downloaded from Azure Repos to the agent's file system.
            - You don't have direct access to the agent that ran your steps.

    7. Link pipeline execution to a commit
        1. In the DevOps resource menu, select **Repos > Commits**

4. Deploy Bicep files by using a pipeline
    1. Service connections
    2. Deploy a Bicep file by using the Azure Resource Group Deployment task
        ```yaml
        - task: AzureResourceManagerTemplateDeployment@3
          inputs:
            connectedServiceName: 'MyServiceConnection'
            location: 'eastasia'
            resourceGroupName: Example
            csmFile: deploy/main.bicep
            overrideParameters: >
                -parameterName parameterValue
        ```

    3. Run Azure CLI and Azure PowerShell commands
    4. Variables
        1. Create a variable
        2. Use a variable in your pipeline
            ```yaml
            - task: AzureResourceManagerTemplateDeployment@3
              inputs:
                connectedServiceName: $(ServiceConnectionName)
                location: $(DeploymentDefaultLocation)
                resourceGroupName: $(ResourceGroupName)
                csmFile: deploy/main.bicep
                overrideParameters: >
                  -environmentType $(EnvironmentType)
            ```
        3. System variables
            - **Build.BuildNumber**
                + is the unique identifier for your pipeline run. 
                + Despite its name, the Build.BuildNumber value often is a string, and not a number. 
                + You might use this variable to name your Azure deployment, so you can track the deployment back to the specific pipeline run that triggered it.

            - **Agent.BuildDirectory**:
                + is the path on your agent machine's file system where your pipeline run's files are stored.
                + This information can be useful when you want to reference files on the build agent.
           
        4. Create variables in your pipeline's YAML file
            ```yaml
            trigger: none

            pool:
              vmImage: ubuntu-latest

            variables:
              ServiceConnectionName: 'MyServiceConnection'
              EnvironmentType: 'Test'
              ResourceGroupName: 'MyResourceGroup'
              DeploymentDefaultLocation: 'eastasia'

            jobs:
            - job:
              steps:
              - task: AzureResourceManagerTemplateDeployment@3
                inputs:
                  connectedServiceName: $(ServiceConnectionName)
                  location: $(DeploymentDefaultLocation)
                  resourceGroupName: $(ResourceGroupName)
                  csmFile: deploy/main.bicep
                  overrideParameters: >
                    -environmentType $(EnvironmentType)
            ```

5. Exercise - Create a service connection
    1. Sign in to Azure
        - To work with service principals in Azure, sign in to your Azure account from the Visual Studio Code terminal.

        1. Sign in to Azure by using the Azure CLI: 
            ```Azure CLI
            az login
            ```

    2. Create a resource group in Azure
        ```Azure CLI
        az group create --name ToyWebsite --location eastasia
        ```

    3. Create a service connection in Azure Pipelines
        - This process automatically creates a service principal in Azure. 
          + It also grants the service principal the Contributor role on your resource group, which allows your pipeline to deploy to the resource group.

        1. Select **Project settings**
        2. Select **Service connections** > **Create service connection**
        3. Select **Azure Resource Manager** > **Next**
        4. Select **Service principal (automatic)** > Next
        5. In the Subscription drop-down, select your Azure subscription
        6. In the **Resource group** drop-down, select **ToyWebsite**
        7. In **Service connection name**, enter **ToyWebsite**.
            - Ensure that the **Grant access permission to all pipelines** checkbox is selected.
            - NOTICE: For simplicity, you're giving every pipeline access to your service connection. 
              + When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

6. Exercise - Add a Bicep deployment task to the pipeline
    1. Add your website's Bicep file to the Git repository
        1. Create **main.bicep** file in **deploy** folder:
          ```Bicep
          @description('The Azure region into which the resources should be deployed.')
          param location string = resourceGroup().location

          @description('The type of environment. This must be nonprod or prod.')
          @allowed([
            'nonprod'
            'prod'
          ])
          param environmentType string

          @description('Indicates whether to deploy the storage account for toy manuals.')
          param deployToyManualsStorageAccount bool

          @description('A unique suffix to add to resource names that need to be globally unique.')
          @maxLength(13)
          param resourceNameSuffix string = uniqueString(resourceGroup().id)

          var appServiceAppName = 'toy-website-${resourceNameSuffix}'
          var appServicePlanName = 'toy-website-plan'
          var toyManualsStorageAccountName = 'toyweb${resourceNameSuffix}'

          // Define the SKUs for each component based on the environment type.
          var environmentConfigurationMap = {
            nonprod: {
              appServicePlan: {
                sku: {
                  name: 'F1'
                  capacity: 1
                }
              }
              toyManualsStorageAccount: {
                sku: {
                  name: 'Standard_LRS'
                }
              }
            }
            prod: {
              appServicePlan: {
                sku: {
                  name: 'S1'
                  capacity: 2
                }
              }
              toyManualsStorageAccount: {
                sku: {
                  name: 'Standard_ZRS'
                }
              }
            }
          }

          var toyManualsStorageAccountConnectionString = deployToyManualsStorageAccount ? 'DefaultEndpointsProtocol=https;AccountName=${toyManualsStorageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${toyManualsStorageAccount.listKeys().keys[0].value}' : ''

          resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
            name: appServicePlanName
            location: location
            sku: environmentConfigurationMap[environmentType].appServicePlan.sku
          }

          resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
            name: appServiceAppName
            location: location
            properties: {
              serverFarmId: appServicePlan.id
              httpsOnly: true
              siteConfig: {
                appSettings: [
                  {
                    name: 'ToyManualsStorageAccountConnectionString'
                    value: toyManualsStorageAccountConnectionString
                  }
                ]
              }
            }
          }

          resource toyManualsStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = if (deployToyManualsStorageAccount) {
            name: toyManualsStorageAccountName
            location: location
            kind: 'StorageV2'
            sku: environmentConfigurationMap[environmentType].toyManualsStorageAccount.sku
          }
          ```

        2. push the changes:
            ```Bash
            git add deploy/main.bicep
            git commit -m 'Add Bicep file'
            git push
            ```

    2. Replace the pipeline steps
        ```yaml
        trigger: none

        pool:
          vmImage: ubuntu-latest

        variables:
        - name: deploymentDefaultLocation
          value: eastasia

        jobs:
        ```
        ```
        jobs:
          - job:
            steps:

            - task: AzureResourceManagerTemplateDeployment@3
              inputs:
                connectedServiceName: $(ServiceConnectionName)
                deploymentName: $(Build.BuildNumber)
                location: $(deploymentDefaultLocation)
                resourceGroupName: $(ResourceGroupName)
                csmFile: deploy/main.bicep
                overrideParameters: >
                  -environmentType $(EnvironmentType)
                  -deployToyManualsStorageAccount $(DeployToyManualsStorageAccount)
        ```

        - NOTE: It's a good idea to type this code yourself instead of copying and pasting it from this module. 
          + Pay attention to the file's indentation. If your indentation isn't correct, your YAML file won't be valid.
          + Visual Studio Code indicates errors by displaying squiggly lines.

        1. Stage your changes,commit them to the repository, and push them to Azure Repos: 
            ```
            git add deploy/azure-pipelines.yml
            git commit -m 'Add deployment task to pipeline'
            git push
            ```

    3. Add pipeline variables
        - Select **Pipelines**, edit your pipeline, add variables:
          + ServiceConnectionName: ToyWebsite
          + ResourceGroupName: ToyWebsite
          + EnvironmentType: nonprod

          + DeployToyManualsStorageAccount: true


    4. Run your pipeline
        - set **DeployToyManualsStorageAccount** to false and run your pipeline

    5. Verify the deployment: go to Resource Group on Azure Portal

7. Use triggers to control when your pipeline runs
    1. What is a pipeline trigger?
    
    2. Branch triggers
        ```yaml
        trigger:
        - main
        ```

        1. Trigger when multiple branches change
            ```yaml
            trigger:
              branches:
                include:
                - main
                - release/*
            ```

        2. Path filters
            ```yaml
            trigger:
              branches:
                include:
                - main
              paths:
                exclude:
                - docs
                include:
                - deploy
            ```

    3. Schedule your pipeline to run automatically
        ```yaml
        schedules:
        - cron: "0 0 * * *"
          displayName: Daily environment restore
          branches:
            include:
            - main
        ```       
        - __0 0 * * *__ means run every day at midnight UTC.                           

    4. Use multiple triggers
        ```yaml
        trigger:
        - main

        schedules:
        - cron: "0 0 * * *"
          displayName: Deploy test environment
          branches:
            include:
            - main
        ```

        - TIP: It's a good practice to set triggers for each pipeline. 
          + If you don't set triggers, by default, your pipeline automatically runs whenever any file changes on any branch, which often isn't what you want.

    5. Concurrency control
        - By default, Azure Pipelines allows multiple instances of your pipeline to run simultaneously.
          + This can happen when you make multiple commits to a branch within a short time.

        - In some situations, having multiple concurrent runs of your pipeline isn't a problem.
          + But when you work with deployment pipelines, it can be challenging to ensure that your pipeline runs aren't overwriting your Azure resources or configuration in ways that you don't expect.

        - To avoid these problems, you can use the **batch** keyword with a trigger, like in this example:
          ```yaml
          trigger:
            batch: true
            branches:
              include:
              - main
          ```
          + When your trigger fires, Azure Pipelines ensures that it waits for any active pipeline run to complete. 
            - Then, it starts a new run with all of the changes that have accumulated since the last run.

8. Exercise - Update your pipeline's trigger
    1. Update the trigger to be branch-based
        - **deploy/azure-pipelines.yml** file:
          ```
          trigger:
            batch: true
            branches:
              include:
              - main
          ```

        - Commit the changes:
          ```
          git add .
          git commit -m 'Add branch trigger'
          ```
    
    2. Update your Bicep file
        - **main.bicep** file:
          ```Bicep
          resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
          name: appServiceAppName
          location: location
          properties: {
            serverFarmId: appServicePlan.id
            httpsOnly: true
            siteConfig: {
              alwaysOn: true // Update
              appSettings: [
                {
                  name: 'ToyManualsStorageAccountConnectionString'
                  value: toyManualsStorageAccountConnectionString
                }
              ]
            }
          }
        }
        ```

        ```
        git add .
        git commit -m 'Configure app Always On setting'
        git push
        ```
        - NOTE: There was a conflict. AlwaysOn cannot be set for this site as the plan does not allow it. 
          + This error message indicates that the deployment failed because the App Service app was deployed by using the F1 free tier, which doesn't support the Always On feature.

        - IMPORTANT: There are some strategies you can use to verify and test your Bicep code.

    3. Verify that the pipeline fails

    4. Fix the Bicep file and see the pipeline triggered again
        1. In Visual Studio Code, add new properties for each environment type to the **environmentConfigurationMap** variable:
            ```Bicep
            var environmentConfigurationMap = {
              nonprod: {
                appServiceApp: { // Update
                  alwaysOn: false
                }
                appServicePlan: {
                  sku: {
                    name: 'F1'
                    capacity: 1
                  }
                }
                toyManualsStorageAccount: {
                  sku: {
                    name: 'Standard_LRS'
                  }
                }
              }
              prod: {
                appServiceApp: { // Update
                  alwaysOn: true
                }
                appServicePlan: {
                  sku: {
                    name: 'S1'
                    capacity: 2
                  }
                }
                toyManualsStorageAccount: {
                  sku: {
                    name: 'Standard_ZRS'
                  }
                }
              }
            }
            ```

        2. Change the application's **alwaysOn** setting to use the appropriate configuration map value for the environment type:
            ```Bicep
            resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
              name: appServiceAppName
              location: location
              properties: {
                serverFarmId: appServicePlan.id
                httpsOnly: true
                siteConfig: {
                  alwaysOn: environmentConfigurationMap[environmentType].appServiceApp.alwaysOn // Update
                  appSettings: [
                    {
                      name: 'ToyManualsStorageAccountConnectionString'
                      value: toyManualsStorageAccountConnectionString
                    }
                  ]
                }
              }
            }
            ```

        3. Commit the changes
            ```Bash
            git add .
            git commit -m 'Enable App Service Always On for production environments only'
            git push
            ```

    5. Verify that the pipeline succeeds

    6. Clean up the resources
        ```
        az group delete --resource-group ToyWebsite --yes --no-wait
        ```
        - The resource group is deleted in the background.

9. References
    - Tasks: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/
        + Azure Resource Group Deployment task: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-resource-group-deployment
        + Azure CLI: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-cli
        + Azure PowerShell: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-powershell
    - Pipeline variables: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?tabs=yaml
        + Predefined variables: https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables?tabs=yaml
    - Pipeline triggers: https://learn.microsoft.com/en-us/azure/devops/pipelines/build/triggers
        + Batching: https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/azure-repos-git#batching-ci-runs
        + Scheduled triggers: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/scheduled-triggers#cron-syntax
    - Agents and self-hosted agents: https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agents
    - Service connections: https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints
