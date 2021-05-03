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
  Write-Host "Removing tasks ..."
  Write-Host
  
  DeleteWorkItemsByType "Task"

  Write-Host
  Write-Host "Creating sprint 2 plan ..."
  Write-Host

  CreateSprint2Plan
}

function CreateTask([int]$parentId, [string]$title, [string]$iteration, [int]$remainingWork)
{
  if ($remainingWork -lt 1) {
    $remainingWork = Get-Random -Minimum 2 -Maximum 8
  }

  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/workitems/$task?api-version=6.0'
  $fields = @(@{"op"= "add"; "path"= "/fields/System.Title";"value"="$title"} ,
              @{"op"= "add"; "path"= "/fields/System.IterationPath";"value"="$iteration"},
              @{"op"= "add"; "path"= "/fields/Microsoft.VSTS.Scheduling.RemainingWork";"value"="$remainingWork"})
  $json = @($fields) | ConvertTo-Json
  try {
    $response = Invoke-RestMethod -Uri $resource -Body $json -headers $headers -Method PATCH -ContentType 'application/json-patch+json'
    $taskId = $response.id
    $resource = $azdoOrg + '/_apis/wit/workitems/' + $taskId + '?api-version=6.0'
    $json = '[{"op": "add","path": "/relations/-","value": {
             "rel": "System.LinkTypes.Hierarchy-Reverse",
             "url": "' + $azdoOrg + '/_apis/wit/workItems/' + $parentId + '"}}]'
    try {
      $response2 = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json-patch+json'
    }
    catch {
      echo $_.Exception|format-list -force
    }
    Write-Host " Created and linked: " -NoNewline
    Write-Host $title -foregroundcolor "yellow"
  }
  catch {
    echo $_.Exception|format-list -force
    return
  }
}

function CreateSprint2Plan
{
  $sprint2 = $azdoProject + "\\Sprint 2" 
  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/wiql/?api-version=6.0'
  $json = '{ "query": "Select [System.ID] FROM WorkItems Where [System.WorkItemType] = ' + "'Product Backlog Item'" + ' AND [System.TeamProject] = ' + "'" + $azdoProject + "'" + ' AND [System.IterationPath] = ' + "'" + $sprint2 + "'" + ' " }'
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'
    foreach ($workItem in $response.workItems) {
      $parentId = $workItem.id
      CreateTask $parentId "Design solution" $sprint2 0
      CreateTask $parentId "Create tests" $sprint2 0
      CreateTask $parentId "Code solution" $sprint2 0
      CreateTask $parentId "Run tests" $sprint2 1
      CreateTask $parentId "Document" $sprint2 1
      write-host
    }
  }
  catch {
    echo $_.Exception|format-list -force
  }
}

function DeleteWorkItemsByType([string]$workItemType)
{
  Write-Host " Deleting any " -NoNewline
  Write-Host $workItemType -foregroundcolor "yellow" -NoNewline
  Write-Host " work items" -NoNewline
  
  if ($workItemType.toLower().Equals("test plan")) {
     DeleteTestPlans
     return
  }
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

Main