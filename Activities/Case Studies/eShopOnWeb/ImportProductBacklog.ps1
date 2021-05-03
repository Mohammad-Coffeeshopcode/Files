function Main
{
  cls

  $azdoOrg = "https://dev.azure.com/<your organization>"
  $azdoToken = "<your personal access token>"
  $azdoProject = "<your project>"

  # Uncomment the following line if necessary
  # Set-ExecutionPolicy Unrestricted

  # Don't change anything below here

  $basicAuth = ("{0}:{1}" -f "",$azdoToken)
  $basicAuth = [System.Text.Encoding]::UTF8.GetBytes($basicAuth)
  $basicAuth = [System.Convert]::ToBase64String($basicAuth)
  $headers = @{Authorization=("Basic {0}" -f $basicAuth)}

  Write-Host
  Write-Host "Removing work items ..."
  Write-Host

  DeleteWorkItemsByType "Epic"
  DeleteWorkItemsByType "Feature"
  DeleteWorkItemsByType "Product Backlog Item"
  DeleteWorkItemsByType "Bug"
  DeleteWorkItemsByType "Task"
  DeleteWorkItemsByType "Impediment"

  Write-Host
  Write-Host "Creating work items ..."
  Write-Host

  # Errors may suggest the Scrum proces was not chosen when the team project was created

  CreateWorkItem "Epic" 500 0 "Integrate with social media" "\" "As CTO, I want to integrate with popular social media platforms, so that we can stay connected to the community"
  CreateWorkItem "Epic" 1300 0 "Avoid being hacked!" "\" "As CIO, I don't want to be hacked like Contoso was, so that we can stay out of the news!"
  CreateWorkItem "Epic" 800 0 "Support our international friends" "\" "As CEO, I want to expand our markets, so that we can be more profitable"

  CreateWorkItem "Feature" 800 0 "Integrate with Facebook" "\Customer\Social" "As the director of social media, I want to integrate with Facebook, so that we can reach our customers"
  CreateWorkItem "Feature" 800 0 "Integrate with Twitter" "\Customer\Support" "As the support manager, I want to integrate with Twitter, so that we can answer questions in real time"
  CreateWorkItem "Feature" 500 0 "Integrate with YouTube" "\Commerce\Marketing" "As the brand manager, I want to integrate with YouTube, so that we create and share valuable content"
  CreateWorkItem "Feature" 300 0 "Integrate with Instagram" "\Customer\Social" "As the director of social media, I want to integrate with Instagram, so that we can market our products"
  CreateWorkItem "Feature" 800 0 "Support German language" "\" "As the director of European operations, I want our website to support German, so that our site will be more popular in Germany and German-speaking countries"
  CreateWorkItem "Feature" 500 0 "Support Spanish language" "\" "As the director of Latin American operations, I want our website to support Spanish, so that our site will be more popular in Spanish-speaking countries"
  CreateWorkItem "Feature" 500 0 "Support Portuguese language" "\" "As the director of European operations, I want our website to support Portuguese, so that our site will be more popular in Brazil and Portugal"
  CreateWorkItem "Feature" 300 0 "Support French language" "\" "As the director of European operations, I want our website to support French, so that our site will be more popular in France and French-speaking countries"
  CreateWorkItem "Feature" 500 0 "Support DHL Express" "\Commerce" "As the director of European operations, I want to offer DHL Express shipping, so that we can reach more regions, cheaply in Europe"
  CreateWorkItem "Feature" 1300 0 "Support Value Added Tax (VAT)" "\Commerce\Accounting" "As the manager of accounting, I want to collect the right taxes from the right countries, so that I can sleep at night"
  CreateWorkItem "Feature" 800 0 "Accept Euros" "\Commerce\Payments" "As the director of European operations, I want to accept Euros, so that my customers can pay with their native currency"
  CreateWorkItem "Feature" 500 0 "Accept British Pounds" "\Commerce\Payments" "As the director of European operations, I want to accept British Pounds, so that my customers can pay with their native currency"
  CreateWorkItem "Feature" 200 0 "Accept BitCoin" "\Commerce\Payments" "As the CTO, I want to accept BitCoin, so that we are hip and cool"
  CreateWorkItem "Feature" 800 0 "Log all activity" "\" "As the security manager, I want to log all website interactions, so that we can refer to it if necessary"
  CreateWorkItem "Feature" 1300 0 "Implement encryption" "\" "As the security manager, I want to encrypt all data and transmissions, so that we reduce our attack surface"
  CreateWorkItem "Feature" 500 0 "Upgrade infrastructure" "\" "As the operations manager, I want to ensure we are running on the latest software, so that we can minimize known exploits"

  CreateWorkItem "Product Backlog Item" 500 5 "View videos on YouTube" "\Commerce\Marketing" "As a potential buyer, I want to view a product video on YouTube, so that I can decide if I like it"
  CreateWorkItem "Product Backlog Item" 800 5 "Share on Facebook" "\Customer\Social" "As a Facebook user, I want to share a cool product on my Facebook news feed, so that my friends can see it"
  CreateWorkItem "Product Backlog Item" 500 8 "Add DHL Express" "\Commerce" "As someone who lives in the EU, I want to have my order delivered via DHL Express, so that I can save money"
  CreateWorkItem "Product Backlog Item" 1300 13 "Compute Value Added Tax (VAT)" "\Commerce" "As an accountant, I want the correct VAT tax computed, so that we are in compliance"
  CreateWorkItem "Product Backlog Item" 800 13 "Compute and display prices in Euros" "\Commerce\Payments" "As a citizen of the EU, I want to see and pay in Euros, so that I don't have to convert in my head"
  CreateWorkItem "Product Backlog Item" 500 13 "Compute and display prices in British Pounds" "\Commerce\Payments" "As a citizen of the UK, I want to see and pay in Pounds, so that I don't have to convert in my head"
  CreateWorkItem "Product Backlog Item" 300 2 "Log HTTP traffic" "\" "As the security manager, I want to log all HTTP requests and responses, so that we can refer to it if necessary"
  CreateWorkItem "Product Backlog Item" 300 3 "Log database interactions" "\Commerce\Security" "As the security manager, I want to log all SQL Server requests and responses, so that we can refer to it if necessary"
  CreateWorkItem "Product Backlog Item" 800 5 "Log merchant services interactions" "\Commerce\Security" "As the security manager, I want to log all merchant services requests and responses, so that we can refer to it if necessary"
  CreateWorkItem "Product Backlog Item" 1300 3 "Configure HTTPS" "\" "As the website administrator, I want to configure HTTPS, so that our website is protected for all sensitive communications"
  CreateWorkItem "Product Backlog Item" 500 8 "Implement SQL Server data encryption" "\Commerce\Security" "As the database administrator, I want to enable SQL Server encryption, so that our data is safe at rest" 
  CreateWorkItem "Product Backlog Item" 200 2 "Upgrade SQL Server" "\" "As the database administrator, I want to upgrade SQL Server to the latest version, so that we have the latest features"
  CreateWorkItem "Product Backlog Item" 100 2 "Show full name, not email" "\Customer\Profile" "As a website user, I want my profile to show my first name and not my email address, so that the experience is more personal"
  CreateWorkItem "Product Backlog Item" 500 1 "Add Azure products" "\Commerce\Catalog" "As an Azure aficionado, I want to see and buy Azure products, so that I can show off to my friends and colleagues"
  CreateWorkItem "Product Backlog Item" 300 1 "Add Visual Studio products" "\Commerce\Catalog" "As a Visual Studio aficionado, I want to see and buy Visual Studio products, so that I can show off to my friends and colleagues"
  CreateWorkItem "Product Backlog Item" 100 1 "Add SQL Server products" "\Commerce\Catalog" "As a SQL Server aficionado, I want to see and buy SQL Server products, so that I can show off to my friends and colleagues"
  CreateWorkItem "Product Backlog Item" 800 8 "No USB memory sticks" "\Commerce\Catalog" "As a potential USB memory stick customer, I want to see some products listed when I select that category, so that I can possibly purchase one"
  CreateWorkItem "Product Backlog Item" 1300 13 "Product search" "\Commerce\Catalog" "As a website visitor, I want to be able to search for products, so that I don't have to browse a bunch of pages"
  CreateWorkItem "Product Backlog Item" 500 3 "Wrong address when checking out" "\Commerce\Payments" "As a buyer, I want to see my own address when I check out, so that I don't think someone else will get my order"
  CreateWorkItem "Product Backlog Item" 300 2 "Stop accepting AMEX" "\Commerce\Payments" "As the CTO, I want to stop accepting American Express, so that we can save money"

  Write-Host
  SetToApproved "Product Backlog Item"
  OrderBacklog "Epic"
  OrderBacklog "Feature"
  OrderBacklog "Product Backlog Item"
}

function CreateWorkItem([string]$type, [int]$businessvalue, [int]$effort, [string]$title, [string]$area, [string]$description, [string]$criteria, [string]$tag)
{

  # Fix fields

  $area = '\'+$azdoProject + $area
  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/workitems/$' + $type + '?api-version=6.0'

  if ($tag) {
    if ($effort -gt 0) {
      $fields = @(@{"op"= "add"; "path"= "/fields/System.Title";"value"="$title"} ,
                  @{"op"= "add"; "path"= "/fields/System.AreaPath";"value"="$area"},
                  @{"op"= "add"; "path"= "/fields/System.Description";"value"="$description"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.BusinessValue";"value"="$businessvalue"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Scheduling.Effort";"value"="$effort"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.AcceptanceCriteria";"value"="$criteria"}
                  @{"op"= "add"; "path"= "/fields/System.Tags";"value"="$tag"})
    }
    else {
      $fields = @(@{"op"= "add"; "path"= "/fields/System.Title";"value"="$title"} ,
                  @{"op"= "add"; "path"= "/fields/System.AreaPath";"value"="$area"},
                  @{"op"= "add"; "path"= "/fields/System.Description";"value"="$description"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.BusinessValue";"value"="$businessvalue"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.AcceptanceCriteria";"value"="$criteria"}
                  @{"op"= "add"; "path"= "/fields/System.Tags";"value"="$tag"})
    }
  }
  else {
    if ($effort -gt 0) {
      $fields = @(@{"op"= "add"; "path"= "/fields/System.Title";"value"="$title"} ,
                  @{"op"= "add"; "path"= "/fields/System.AreaPath";"value"="$area"},
                  @{"op"= "add"; "path"= "/fields/System.Description";"value"="$description"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.BusinessValue";"value"="$businessvalue"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Scheduling.Effort";"value"="$effort"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.AcceptanceCriteria";"value"="$criteria"})
    }
    else {
      $fields = @(@{"op"= "add"; "path"= "/fields/System.Title";"value"="$title"} ,
                  @{"op"= "add"; "path"= "/fields/System.AreaPath";"value"="$area"},
                  @{"op"= "add"; "path"= "/fields/System.Description";"value"="$description"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.BusinessValue";"value"="$businessvalue"},
                  @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Common.AcceptanceCriteria";"value"="$criteria"})
    }
  }  
  $json = @($fields) | ConvertTo-Json
  try {
    $response = Invoke-RestMethod -Uri $resource -Body $json -headers $headers -Method PATCH -ContentType 'application/json-patch+json'
    Write-Host " Created" $type": " -NoNewline
    Write-Host $title -foregroundcolor "yellow"
  }
  catch {
    echo $_.Exception|format-list -force
    return
  }
}

function SetToApproved([string]$workItemType)
{
  write-host -NoNewline "Setting" $workItemType"s to Approved "

  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/wiql/?api-version=6.0'
  $json = '{ "query": "Select [System.ID] FROM WorkItems Where [System.WorkItemType] = ' + "'" + $workItemType + "'" + ' AND [System.TeamProject] = ' + "'" + $azdoProject + "'" + '" }'
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'
    foreach ($workItem in $response.workItems) {
      $id = $workItem.id
      $resource = $azdoOrg + '/_apis/wit/workitems/' + $id + '?api-version=6.0'
      $json = '[{"op": "add","path": "/fields/System.State","value": "Approved"}]'
      try {
        $response2 = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json-patch+json'
      }
      catch {
        echo $_.Exception|format-list -force
      }
      write-host -NoNewline "."
    }
  }
  catch {
    echo $_.Exception|format-list -force
  }
  write-host
}

function DeleteWorkItemsByType([string]$workItemType)
{
  Write-Host " Deleting any " -NoNewline
  Write-Host $workItemType -foregroundcolor "yellow" -NoNewline
  Write-Host " work items" -NoNewline
 
  $workItemCount = 0
  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/wiql/?api-version=6.0'
  $json = '{ "query": "Select [System.ID] FROM WorkItems Where [System.WorkItemType] = ' + "'" + $workItemType + "'" + ' AND [System.TeamProject] = ' + "'" + $azdoProject + "'" + '" }'
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'
    foreach ($workItem in $response.workItems) {
      $id = $workItem.id
      $resource = $azdoOrg + '/_apis/wit/workitems/' + $id + '?api-version=6.0'
      try {
        $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Delete
        $workItemCount++
      }
      catch {
        echo $_.Exception|format-list -force
      }
    }
  }
  catch {
    echo $_.Exception|format-list -force
  }

  Write-Host " (" -NoNewline
  if ($workItemCount -gt 0)
   { Write-Host $workItemCount -foregroundcolor "yellow" -NoNewline }
  else
   { Write-Host 0 -NoNewline }
  Write-Host ")"
}
function DeleteTestPlans()
{
  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/test/plans/?api-version=6.0'
  $testPlans = New-Object System.Collections.ArrayList

  $workItemCount = 0

  # Enumerate test plans
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Get -ContentType 'application/json'
    $response.value | Sort-Object -Property name | ForEach-Object {
      $testPlans.add($_.id) | out-null
    }
  }
  catch {
    echo $_.Exception|format-list -force
  }

  # Delete each plan

  foreach ($testPlan in $testPlans) {
    # write-host $testPlan" " -nonewline
    $resource = $azdoOrg + "/" + $azdoProject + '/_apis/test/plans/' + $testPlan + '?api-version=6.0'
    try {
      $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Delete
      $workItemCount++
    }
    catch {
      echo $_.Exception|format-list -force
    }
  }
  Write-Host " (" -NoNewline
  if ($workItemCount -gt 0)
   { Write-Host $workItemCount -foregroundcolor "yellow" -NoNewline }
  else
   { Write-Host 0 -NoNewline }
  Write-Host ")"
}

function OrderBacklog([string]$workItemType)
{
  write-host -NoNewline "Ordering the" $workItemType "backlog by ROI "

  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/wiql/?api-version=6.0'
  $json = '{ "query": "Select [System.ID] FROM WorkItems Where [System.WorkItemType] IN (''' + $workItemType + ''') AND [System.TeamProject] = ' + "'" + $azdoProject + "'" + '" }'
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'

    # write-host ":"$response.workItems.Count "items"
    # write-host -NoNewline "Retrieving work items: "

    $count = $response.workItems.count
    $backlog = New-Object 'object[,]' $count, 7
    # ,0 = ID
    # ,1 = Title
    # ,2 = Business Value
    # ,3 = Effort
    # ,4 = ROI
    # ,5 = BacklogPriority

    $item = 0

    foreach ($workItem in $response.workItems) {
      $id = $workItem.id

      write-host -NoNewline "."

      $resource2 = $azdoOrg + '/_apis/wit/workitems?ids=' + $id + '&$expand=all&api-version=6.0'
      $response2 = Invoke-RestMethod -Uri $resource2 -headers $headers -Method Get -ContentType 'application/json'

      # Get and save fields to array

      $businessvalue = GetValue $response2.value.fields "Microsoft.VSTS.Common.BusinessValue"
      $effort = GetValue $response2.value.fields "Microsoft.VSTS.Scheduling.Effort"
      $backlog[$item,0] = $id
      $backlog[$item,1] = GetValue $response2.value.fields "System.Title"
      $backlog[$item,2] = $businessvalue
      $backlog[$item,3] = $effort

      if (!$businessvalue -eq 0)
      {
        if (!$effort -eq 0)
        {
           $backlog[$item,4] = ($businessvalue / $effort) + 100 # Added 100 to make room for BV w/o Effort below
        }
        else
        {
           $backlog[$item,4] = $businessvalue # was 50 # BV w/o Effort should be above no BV
        }
      }
      else
      {
        $backlog[$item,4] = 0 # No BV = No ROI
      }
      $backlog[$item,5] = 0

      # write-host $businessvalue "/" $effort "=" $backlog[$item,4] "(" $backlog[$item,5] ")"

      $item++
    }

    # write-host
    # write-host -NoNewline "Computing ROI: "

    for ($i=0; $i -lt $count; $i++) {
      write-host -NoNewline "."

      $id = $backlog[$i,0]
      $val1 = [int]2147483647 # int maxvalue
      $val2 = [int]$backlog[$i,4] # ROI
      $backlog[$i,6] = ($val1 - $val2) # higher ROIs have lower priorities
    }

    # write-host
    # write-host -NoNewline "Reordering Backlog: "

    for ($i=0; $i -lt $count; $i++) {
      write-host -NoNewline "."

      $id = $backlog[$i,0]
      $backlogPriority = $backlog[$i,6]
      $resource2 = $azdoOrg + '/_apis/wit/workitems/' + $id + '?api-version=6.0'
      $json = '[{"op": "add","path": "/fields/Microsoft.VSTS.Common.BacklogPriority","value": '+$backlogPriority+'}]'
      try {
        $response2 = Invoke-RestMethod -Uri $resource2 -headers $headers -Method Patch -Body $json -ContentType 'application/json-patch+json'
      }
      catch {
        echo $_.Exception|format-list -force
      }
    }
    write-host
    # Uncomment for troubleshooting
    # write-host
    # write-host "Backlog has been ordered by ROI"
    # $backlog
  }
  catch {
    echo $_.Exception|format-list -force
  }
}

function GetValue($fields,$searchField)
{
  $value = ""
  foreach ($field in $fields) {
    $field.PsObject.get_properties() | foreach {
      if ($_.Name -eq $searchField) {
        $value = $_.Value
      }
    }
  }
  return $value
}

Main