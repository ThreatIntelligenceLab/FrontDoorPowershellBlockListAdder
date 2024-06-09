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
