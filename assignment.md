# Assignment 1
1. Rename the resource group in Azure from `technology-joseph-learning` to `technology-joseph` using terraform
2. Create a Windows 2022 Server on resource group `technology-joseph` manually. Makes sure you can RDP (connect to the VM) using your desired username and password.

# Assignment 2
1. Provision two Ubuntu 24.04 Linux Virtual Machine on Azure using terraform.
2. Use variables, like we did on Windows VM, dynamic block and use for loop.
3. Enable port 22 (ssh) and port 80. SO that we can ssh and connect to the VM(s).

# Assignment 3
1. Update [windows-vm resource](https://github.com/jojo-orgs/azure-windows/blob/main/main.tf#L74-L100) to not use `for_each` and use `dynamic block`. See [linux-vm resource](https://github.com/jojo-orgs/azure-linux/blob/main/main.tf#L69-L102).
2. Create a module in the [child module](https://github.com/jojo-engineer/terraform/blob/main/main.tf) for windows vm. Like how we did for linux. Create tag `v1.0.0` and `source` the git repo.
```hcl
module "windows-vm" {
    source = "git repo"
}
```
3. Test the functionality to make sure the windows modules work as expected.