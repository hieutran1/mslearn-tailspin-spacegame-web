# Terraform
- https://learn.microsoft.com/en-us/training/paths/terraform-fundamentals/

## Introduction
1. Introduction
    - Infrastructure as code, sometimes referred to as IaC, is a way to provision infrastructure resources that's similar to how software is deployed. 
      + These resources include virtual machines, virtual networks, and web applications. 
      + Infrastructure as code can help automate your deployments, increase confidence in your deployments, and increase efficiency and repeatability.

2. Example scenario
    - Suppose you work as an Azure infrastructure administrator at a toy company that's experiencing significant growth in the global market. As a result, your infrastructure needs to scale with the company's growth, including:
      + Deployments of new applications for internal teams and customers.
      + Multiple region deployments to support your customers and partners around the world.
      + Multiple environment deployments to ensure consistency.

    - Evaluate whether infrastructure as code might be a valuable approach to resource provisioning at your company. 
      + You also need to decide which technology to use when you deploy your Azure infrastructure.

## What is infrastructure as code?
1. Defining infrastructure as code
2. Why use infrastructure as code?
    - Adopting an infrastructure as code approach offers many benefits to resource provisioning:
      + Increase confidence in your deployments.
      + Manage multiple environments.
      + Better understand your cloud resources.

    1. Increase confidence
    2. Manage multiple environments
    3. Better understand your cloud resources
3. Imperative and declarative code
    1. Imperative code
    2. Declarative code
        - In Azure, a declarative code approach is accomplished by using templates or modules. Many types are available to use, including:
          + Terraform, by HashiCorp
          + Bicep
          + ARM JSON

## Compare Azure Resource Manager and Terraform State
1. Azure Resource Manager vs Terraform state
    1. Azure Resource Manager
    2. Terraform State

2. Comparison of Azure Resource Manager and Terraform State

## What is Terraform?
1. Terraform language - HashiCorp Configuration Language (HCL)
2. Benefits of Terraform

## How Terraform works
- In this unit, you learn about how Terraform works with providers and state files.

1. Terraform CLI
    - Install: https://developer.hashicorp.com/terraform/install

2. Terraform providers
    - Microsoft curates many providers in collaboration with HashiCorp and the community. These providers include:
      + azurerm: https://registry.terraform.io/providers/hashicorp/azurerm
        - This provider is the most user friendly way to deploy resources into Azure.
        - This provider may take time to support new Azure features.

      + azapi: https://registry.terraform.io/providers/Azure/azapi
        - This provider enables deployment of any Azure resource, including resources in preview.
        - It's always up to date with the latest Azure features.

      + azuread: https://registry.terraform.io/providers/hashicorp/azuread
        - This provider is used to managed Microsoft Entra ID. 
        - It can manage many features, including user, groups, and service principals.

      + azuredevops: https://registry.terraform.io/providers/microsoft/azuredevops
        - This provider is used to manage all aspects of Azure DevOps, including repos, pipelines, and projects.

      + github: https://registry.terraform.io/providers/integrations/github
        - This provider is used to manage all aspects of GitHub, including organizations, repositories, and actions.

3. Terraform Workflow
    - When using the Terraform CLI, there a four fundamental steps in the workflow:
      + Write: Write the HCL code to define your desired state.
      + Init: Pull down providers and modules. Connect to remote state.
      + Plan: Generates a plan to bring actual state into line with desired state, by querying your deployed resources and comparing to the configuration.
      + Apply: Implement the plan and bring the target environment in line via API calls.

4. Terraform LifeCycle 
    - Terraform is designed and should be used to manage the lifecycle of your resources.
    - By using a state file, Terraform can manage your resources through these stages:
      1. Create: The resource is in desired state, but doesn't exist in actual state and is created in Azure.
      2. Update: The desired state of the resource attributes doesn't match the actual state and the resource is updated to bring in line with desired state.
      3. Destroy: The resource no longer exists in desired state and is deleted from Azure.

5. Terraform State

## When to use Terraform
1. Is Terraform the right tool?
2. When is Terraform the right tool?
3. When is Terraform not the right tool?

## Summary

## Next steps
- Learn more about **Terraform on Azure**: https://learn.microsoft.com/en-us/azure/developer/terraform
- Learn more about **Terraform**: https://developer.hashicorp.com/terraform