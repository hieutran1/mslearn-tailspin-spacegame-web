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
2.
3.

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
