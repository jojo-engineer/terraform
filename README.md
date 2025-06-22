# Terraform

Terraform is an Infrastructure as Code (IaC) tool that allows users to define and provision data center infrastructure using a declarative configuration language.

## Getting Started

Before you begin automating with Terraform, follow these steps:
1. **Understand Your Resources**: Manually create resources in the cloud and explore the cloud console to understand how resources are created.
2. **Plan Your Automation**: Once you have a good understanding of the resources, start automating the process using Terraform.

## Key Concepts

### Resource Group
A **Resource Group** is a collection of resources that are managed together.

## Common Terraform Commands

Here’s a list of commonly used Terraform commands:

### Initialization
- **`terraform init`**: Initializes a Terraform working directory, downloading the necessary provider plugins and setting up the backend.

### Planning and Applying
- **`terraform plan`**: Creates an execution plan, showing what actions Terraform will take to match the configuration.
- **`terraform apply`**: Applies the changes required to reach the desired state of the configuration, creating or updating resources as necessary.

### Formatting and Validation
- **`terraform fmt`**: Formats Terraform configuration files to a canonical format and style.
- **`terraform validate`**: Validates the Terraform configuration files for syntax errors and other issues.

### State Management
- **`terraform state`**: Manages the Terraform state file, allowing you to view, modify, or remove resources from the state.
  - **`terraform state list`**: Lists all resources in the current Terraform state.
  - **`terraform state show`**: Displays detailed information about a specific resource in the Terraform state.
  - **`terraform state rm`**: Removes a resource from the Terraform state.
  - **`terraform state mv`**: Moves a resource from one address to another in the Terraform state.

### Workspaces
- **`terraform workspace`**: Manages multiple workspaces, allowing you to have different states for different environments (e.g., development, staging, production).
  - **`terraform workspace new`**: Creates a new workspace.
  - **`terraform workspace select`**: Switches to a specified workspace.
  - **`terraform workspace list`**: Lists all available workspaces.
  - **`terraform workspace delete`**: Deletes a specified workspace.

### Resource Management
- **`terraform import`**: Imports existing infrastructure into Terraform management.
- **`terraform taint`**: Marks a resource for recreation during the next apply.
- **`terraform untaint`**: Removes the taint mark from a resource.

### Debugging and Visualization
- **`terraform show`**: Displays the current state of the Terraform-managed infrastructure.
- **`terraform graph`**: Generates a visual representation of the dependency graph of the resources.

### Miscellaneous
- **`terraform output`**: Displays the output values defined in the Terraform configuration.
- **`terraform console`**: Opens an interactive console for evaluating expressions and inspecting the Terraform state.

## Notes

- Always ensure you have a clear understanding of the resources you want to create before automating with Terraform.
- Use `terraform fmt` to maintain consistent formatting across your configuration files.

---

This README provides a structured overview of Terraform and its commands, making it easier to understand and use.


## Day 2 – June 22, 2025

### Variable Blocks in Terraform

A **variable block** in Terraform is used to define input variables that can be passed to a Terraform configuration. This allows you to parameterize your infrastructure code, making it more flexible and reusable.

#### Example Variable Block

```hcl
variable "example_variable" {
  type        = string
  description = "An example variable for demonstration purposes."
  default     = "default_value"
}
```

#### What is a Variable Block?

A variable block in Terraform defines an input variable, specifying its type, description, and optionally a default value. These variables can be referenced throughout your Terraform configuration, allowing you to customize deployments without changing the code.

---

### Supported Data Types for Variables

- **string**: A sequence of characters, often used for text.  
  *Example:* `"Hello, World!"`

- **number**: A numeric value, which can be an integer or a floating-point number.  
  *Example:* `42` or `3.14`

- **bool**: A boolean value, which can be either `true` or `false`.  
  *Example:* `true` or `false`

- **list**: An ordered collection of values, which can be of any type.  
  *Example:* `["apple", "banana", "cherry"]`

- **map**: A collection of key-value pairs, where keys are strings and values can be of any type.  
  *Example:* `{"name": "John", "age": 30}`

- **object**: A complex data structure that can contain multiple attributes, each with its own type.  
  *Example:*
  ```hcl
  {
    name      = "John Doe"
    age       = 30
    is_active = true
  }
  ```

- **set**: An unordered collection of unique values, which can be of any type.  
  *Example:* `{"apple", "banana", "cherry"}`

- **tuple**: An ordered collection of values, where each value can be of a different type.  
  *Example:* `[42, "Hello", true]`

- **any**: A special type that can accept any value, regardless of its type.  
  *Example:* Any value can be passed, such as a string, number, or

## Output block

### What is an output block in Terraform?

An **output block** in Terraform is used to define outputs that can be displayed after the execution of a Terraform configuration. Outputs are useful for providing information about the resources created, such as their IDs or IP addresses.

### Example of an output block in Terraform

```hcl
output "example_output" {
  value       = "This is an example output"
  description = "An example output for demonstration purposes."
}
```

---

## What is Interpolation in Terraform?

Interpolation in Terraform refers to the process of dynamically constructing strings using variables, resource attributes, and other expressions.  
It allows you to create more flexible and reusable configurations by embedding values into strings.  
Interpolation is typically done using the `${}` syntax, where you can include variables, resource attributes, and functions.

### Example of Interpolation in Terraform

```hcl
variable "name" {
  description = "The name of the resource"
  type        = string
  default     = "example"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-testnetwork" # example-testnetwork
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name
}

resource "azurerm_resource_group" "joseph-rg" {
  name     = "${var.name}-${var.resource_group_name}" # example-technology-joseph-learning
  location = var.location
}
```