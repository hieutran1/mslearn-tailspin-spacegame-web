# Azure

- ISO: https://www.iso.org/about

## Azure for developers

- https://learn.microsoft.com/en-us/azure/developer/intro/
- Resource Naming: 
    + Format: `[Resource Type]-[Workload/Application]-[Environment]-[Azure Region]-[Instance]`
    + Resource group: rg-utomadapter-dev-uksouth-001
    + Azure kubernetes: aks-
- Passwordless connections for Azure services:
    + https://learn.microsoft.com/en-us/azure/developer/intro/passwordless-overview
    
1. Azure billing
    1. Azure Account:
        - Azure account is to sign in to Azure.
        - Organization's Azure administrators, assign **groups** or **roles** to personal account.
            + Check **permissions** assigned to your account.
    2. Azure subscription:
        - Billing for Azure resources is done on a per-subscription basis.
        - Organization: create one subscription for each department.
        - Types of subscription: 
            + *Pay-as-you-go subscription*: their credit card
            + *Visual Studio Enterprise subscription*: monthly Azure credits

    3. What factors influence the cost of a service on Azure?
        1. Compute power: 
            - amount of CPU and memory assigned to a resource.
            - ramp up when demand is high but scale back and save money when demand is slow.
        2. Storage amount: amount of data
        3. Storage hardware: 
            - long-term storage, slower read & write speeds.
            - low latency read and writes for highly transactional operations.
        4. Bandwidth: ingress -> incoming requests, Egress -> outgoing data.
        5. Per use: number of times, number of requests, number of some entity
        6. Per service: monthly fee
        7. Region: hosted

    4. What tools are available to monitor and analyze my cloud spend?
        1. Cost alerts: https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending
        2. Azure Cost Management: https://learn.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview
            - optimize cost: https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/cost-mgt-best-practices

2. Key concepts for building Azure apps
    1. Azure regions
    2. Azure resource group
        - rg-dev: App Service, SQL Database, Blob Storage, Key Vault
    3. Environments: Dev, Test, Prod
        - rg-dev: AppService-dev, SQLDatabase-dev, BlobStorage-dev, KeyVault-dev
        - rg-test
        - rg-prod: AppService-prod, SqlDatabase-prod

    4. DevOps support:
        - GitHub Actions, Azure DevOps
        - Octopus Deploy
        - Jenkins
        - Terraform, Bicep, Ansible
        - Chef

3. Create Azure Resources
    1. Azure Portal 

    2. VS Code Azure Tools Extension Pack

    3. Command line tools: 
        1. Azure CLI (Bash)
        2. Azure PowerShell (PS1): Azure PowerShell is installed as a **PowerShell module**
            - PowerShell 7.0.6 LTS

            - Install PowerShell AZ module: `Install-Module -Name Az -Force`

    4. Infrastructure as Code tools
        1. Bicep: is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources.
            - Docs: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/
            - VS Code extension: **ms-azuretools.vscode-bicep**
            - VS extension: **ms-azuretools.visualstudiobicep**
            - Learn:
                + Quickstart: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code
                + Learn Modules for Bicep: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/learn-bicep

            - Preview changes: **what-if operation**
                + https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-what-if?tabs=azure-powershell%2CCLI

            - Demo: Test Modification:
                ``` Azure Powershell
                New-AzResourceGroup `
                -Name ExampleGroup `
                -Location centralus

                New-AzResourceGroupDeployment `
                -ResourceGroupName ExampleGroup `
                -TemplateFile "what-if-before.bicep"

                New-AzResourceGroupDeployment `
                -Whatif `
                -ResourceGroupName ExampleGroup `
                -TemplateFile "what-if-after.bicep"

                Remove-AzResourceGroup -Name ExampleGroup
                ```

                ``` Azure CLI
                az group create \
                --name ExampleGroup \
                --location "Central US"

                az deployment group create \
                --resource-group ExampleGroup \
                --template-file "./devops/create-azure-resources/Bicep/main.bicep"

                az deployment group what-if \
                --resource-group ExampleGroup \
                --template-file "./devops/create-azure-resources/Bicep/main.bicep"

                Clean up resources:
                    az group delete --name ExampleGroup
                ```

        2. Terraform:
            - "Hashicorp Terraform" is an open-source tool for provisioning and managing cloud infrastructure.
            - Docs: https://learn.microsoft.com/en-us/azure/developer/terraform/
            - VS Code extension: "azure terraform", **ms-azuretools.vscode-azureterraform**
            
            - Demo:


        3. Ansible:
            - Ansible is an open-source product that automates cloud provisioning, configuration management, and application deployments.
            - Docs: https://learn.microsoft.com/en-us/azure/developer/ansible/

    5. Azure SDK and REST APIs

4. Key Azure services for developers
    1. App hosting and compute
        - Azure App Service
        - Azure Static Web Apps
        - Azure Container Apps: run containerized applications without worrying about orchestration or infrastructure via a serverless platform.
        - Azure Container Instances: Azure Container Instances is a solution for any scenario that can operate in **isolated containers**, without orchestration.
        - Azure Kubernetes Services: Quickly deploy a production ready Kubernetes cluster to the cloud. Azure: health monitoring and maintenance. User: agent nodes.
        - Azure Virtual Machines: computing environment.
        - Azure Functions: serverless compute platform.
        - Azure Spring Apps

    2. Azure AI services: to create AI apps.
        - Azure OpenAI: language models like GPT-3, Codex.
        - Azure AI Speech: Transcribe audible speech.
        - Azure AI Language: identify key phrases.
        - Azure AI Translator: 100 languages
        - Azure AI Vision: Analyze content in images and video.
        - Azure AI Search
        - Azure AI Document Intelligence: Document extraction service.

    3. Data: relational and NoSQL storage.
        - Azure SQL: SQL Server database engine
        - Azure SQL Database: cloud-based version of SQL Server.
        - Azure Cosmos DB: cloud-based NoSQL database --> MongoDB, Cassandra and Gremlin.
        - Azure Database for PostgreSQL: PostgreSQL Community Edition
        - Azure Database for MySQL: MySQL Community Edition
        - Azure Database for MariaDB: MariaDB community edition
        - Azure Cache for Redis: A secure data cache and messaging broker

    4. Storage
        - Azure Blob Storage: files
        - Azure Data Lake Storage: big data analytics; structured, semi-structured or unstructured data.

    5. Messaging: sending, receiving, and routing of messages.
        - Azure Service Bus: managed enterprise message broker; point to point and publish-subscribe integrations.
            + building decoupled applications, queue-based load leveling, or facilitating communication between microservices.
        - Azure Event Hubs: ingest and process **massive data streams** from websites, apps, or devices.
        - Azure Queue Storage: handle large workloads.

    6. Identity and security
        - Microsoft Entra ID
        - Azure Key Vault
        - App Configuration

    7. Management
        - Azure Monitor
        - Application Insights

5. Hosting applications on Azure
    - Do you prefer **simplicity** or **control**?
    - Do you prefer **cloud-native** (i.e., **containers**, **Dapr**, **Aspire**) or **Azure-native** (tailored tools and integrations)
    1. Simplified hosting: fully managed by Azure; Azure-native approach
        - Logic Apps: automated workflows with little to no code.
        - Power Automate: https://learn.microsoft.com/en-us/power-automate
            + automate business processes and workflows.
        - Azure Static Web Apps: Blazor and React.
        - Azure Functions Apps: serverless code or container hosting.
    2. Balanced hosting: both Azure-native and Cloud-native. User: code and environment configuration. Azure: underlying runtime and infrastructure.
        - Azure App Service: Full-service web hosting
        - Azure Container Apps: Serverless container hosting
        - Azure Spring Apps: Spring Boot applications
    3. Controlled hosting: cloud-native approach. Responsible for updates and patches as well as the code, assets, and environment configuration.
        - Azure Virtual Machines: Full control of VM
        - Azure Kubernetes Service: Full control of Kubernetes cluster

    4. Source-code hosting
        - 4.1 No code or low code --> enterprise or business to business: Power Apps or Logic Apps
            + **Power Automate** such as **Power apps**: Microsoft 365 organization

        - 4.2 Code
            + Client or Client + API: Azure static web apps + Azure Functions Apps
            + Full stack or API or Server or Automation: Azure App Service, Azure Spring Apps
            + Stateless: Azure Functions Apps

        - 4.3 Container: 
            + 1 Stateless: Azure Functions Apps
            + 2 Stateful: Azure Container Apps

        - 4.4 Code vs container
            + Low-code hosting: Azure Functions, Azure Static Web Apps
            + Code-first hosting: Azure App Service, Azure Spring Apps
            + Container-first hosting: to host containers
            + Kubernetes-centric orchestration hosting includes: 
                - Azure Kubernetes Service: Cload-native
                - Azure Service Fabric: Azure-native

            + Preconfigured container hosting, Azure Container Registry

        - 4.5 Serverless hosting: consumption-based pricing tier
            + Azure Container Apps: use for Container hosting
            + Azure Functions: use for Code or container hosting

        - 4.6 Microservices hosting: Microservices are typically deployed as containers
            + Azure Container Apps: Use for serverless containerized microservices
            + Azure Functions: Use for serverless code or containerized microservices

        - 4.7 Cloud edge
            + Client compute: 
                - Azure Static Web Apps: Use for static web apps that use client-side rendering such as React, Angular, Svelte, Vue, and Blazor.
            + Client availability: 
                - Azure Front Door: DDoS protection, end-to-end TLS encryption, application firewalls, and geo-filtering.
            + Server compute: integrated with other Azure services.
                - Azure App Service
                - Azure Functions
                - Azure Spring Apps
                - Azure Container Apps: Use to host managed microservices and containerized applications on a serverless platform.
                - Azure Container Instances: Use this for simple container scenarios that don't need container orchestration.
                - Azure Kubernetes Service: Use this service when you need a Kubernetes cluster.

            + Server Endpoint Management: manage the server endpoint and its compute through a gateway.
                - The gateway provides functionality such as versioning, caching, transformation, API policies, and monitoring.

                - Azure API Management: Use this service when you productize your **REST**, **OpenAPI**, and **GraphQL APIs** with an API gateway including quotas and rate limits, authentication and authorization, transformation, and cached responses.
                - Azure Application Gateway: Use for **regional load balancing** (OSI layer 7). 
                - Azure Front Door: Use for **global load balancing** (OSI layer 7) to provide a global cached and secure network to your static and dynamic assets.
                - Azure Traffic Manager: Use for distributing traffic by **DNS** (OSI layer 7) to your public facing applications across the global Azure regions.

            + Automated compute: typically used for background processing, batch processing, or long-running processes
                - Power Automate
                - Azure Functions
                - Container services (Azure Container Instances, Azure Kubernetes Service, Azure Container Apps)
                - Azure Batch: Use when you need high-performance automation
                    + https://learn.microsoft.com/en-us/azure/batch/batch-technical-overview

        - 4.8 Hybrid cloud
            - Azure Arc: Use when need to manage your entire environment, both cloud and on-premises resources.
            - Azure Stack HCI

        - 4.9 High performance computing
            - Azure Batch
            - Azure BareMetal Instances
            - Azure Quantum workspace
            - Microsoft Genomics

        - 4.10 Event-based compute
            - Power Virtual Agents: chatbots 
            - Azure Functions
            - Azure Service Bus Messaging: Use when you need to decouple applications and services

        - 4.11 CI/CD compute


