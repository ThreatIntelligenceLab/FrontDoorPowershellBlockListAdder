# FrontDoorPowershellBlockListAdder
Add items to your Azure Front Door Blocklist

## Tutorial: Automating IP Address Blocking in Azure Front Door WAF Using PowerShell Script
>> Part of guide on [How to do Front Door WAF with Powershell](https://threatintelligencelab.com/blog/configuring-azure-front-doors-waf-policy-using-powershell/)

### Introduction:
Azure Front Door Web Application Firewall (WAF) provides security features to protect web applications from common threats. In this tutorial, you'll learn how to use a PowerShell script to automate the process of blocking IP addresses in Azure Front Door WAF by reading them from a CSV file.

### Prerequisites:
1. Azure subscription with access to Azure Front Door service.
2. Azure PowerShell module installed on your local machine.
3. Basic understanding of PowerShell scripting.

### Step 1: Create a CSV File:
Create a CSV file named "blocklist.csv" containing a list of IP addresses you want to block. Each row should contain a single IP address under the column header "IPAddress".

Example blocklist.csv:
IPAddress
192.168.0.1
10.0.0.2


### Step 2: Write the PowerShell Script:
Open a text editor and copy the following PowerShell script:

```powershell
# Import the contents of the blocklist.csv file
$blocklist = Import-Csv -Path "blocklist.csv"

# Loop through each IP address in the blocklist
foreach ($entry in $blocklist) {
    $ipAddress = $entry.IPAddress

    # Add the IP address to the blocklist using Add-AzFrontDoorWafManagedRuleExclusion command
    Add-AzFrontDoorWafManagedRuleExclusion -ResourceGroupName "YourResourceGroup" `
                                           -WafPolicyName "YourWafPolicyName" `
                                           -MatchVariable "RequestHeaderNames" `
                                           -Selector "User-Agent" `
                                           -Operator "Equals" `
                                           -Value $ipAddress `
                                           -MatchVariableType "Main"
}
```
Replace "YourResourceGroup" and "YourWafPolicyName" with your actual Azure resource group name and WAF policy name.

### Step 3: Run the Script:
Save the PowerShell script with a ".ps1" extension, for example, "blockIPs.ps1". Open PowerShell, navigate to the directory containing the script, and execute it by typing .\blockIPs.ps1 and pressing Enter.

### Step 4: Verify the Blocking:
After running the script, verify that the specified IP addresses are successfully added to the blocklist in Azure Front Door WAF.

### Author
Made by [Reza Rafati](https://www.linkedin.com/in/rezar1/), Threat Intelligence Lab | [ThreatIntelligenceLab.com](https://ThreatIntelligenceLab.com)
