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

  Write-Host "Creating teams ..."
  Write-Host

  CreateTeam Commerce "Commerce team"
  CreateTeam Customer "Customer experience team"
  CreateTeam Mobile "Mobile experience team"
  CreateTeam NIT "Nexus Integration Team"

  Write-Host
  Write-Host "Creating areas ..."
  Write-Host

  CreateArea Commerce ""
  CreateArea Customer ""
  CreateArea Mobile ""
  CreateArea NIT ""
  CreateArea Accounting Commerce
  CreateArea Catalog Commerce
  CreateArea Marketing Commerce
  CreateArea Payments Commerce
  CreateArea Reports Commerce
  CreateArea Security Commerce
  CreateArea Alerts Customer
  CreateArea Profile Customer
  CreateArea Reports Customer
  CreateArea Security Customer
  CreateArea Social Customer
  CreateArea Support Customer
  CreateArea Browser Mobile
  CreateArea Native Mobile
  CreateArea Payments Mobile
  CreateArea Security Mobile
  CreateArea Integration NIT
  CreateArea Dependencies NIT
  CreateArea Operations NIT
  CreateArea "Technical debt" NIT

  Write-Host
  Write-Host "Setting team areas ..."
  Write-Host

  SetTeamArea $azdoProject" Team" ""
  SetTeamArea Commerce Commerce
  SetTeamArea Customer Customer
  SetTeamArea Mobile Mobile
  SetTeamArea NIT NIT

  Write-Host
  Write-Host "Creating iterations ..."
  Write-Host

  # Determine when sprint 2 starts (sprint 1 is finished)
  $today = Get-Date
  $sprint2starts = $today.AddDays((3 - $today.DayOfWeek.value__ - 7) % 7)
  CreateIteration "Sprint 1" $sprint2starts.AddDays(-14)
  CreateIteration "Sprint 2" $sprint2starts
  CreateIteration "Sprint 3" $sprint2starts.AddDays(14)
  CreateIteration "Sprint 4" $sprint2starts.AddDays(28)
  CreateIteration "Sprint 5" $sprint2starts.AddDays(42)
  CreateIteration "Sprint 6" $sprint2starts.AddDays(56)

  Write-Host
  Write-Host "Setting team iterations ..."
  Write-Host

  SetTeamIterations $azdoProject" Team"
  SetTeamIterations Commerce
  SetTeamIterations Customer
  SetTeamIterations Mobile
  SetTeamIterations NIT
}

function CreateTeam([string]$team, [string]$description)
{
  $resource = $azdoOrg + "/_apis/projects/" + $azdoProject + "/teams?api-version=6.0"
  $json = @{name=$team} | ConvertTo-Json
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'
    Write-Host ""$team -foregroundcolor "yellow" -NoNewline
    Write-Host " created"
  }
  catch {
    Write-Host ""$team -foregroundcolor "yellow" -NoNewline
    Write-Host " already exists"
  }

  # Description

  $resource = $azdoOrg + "/_apis/projects/" + $azdoProject + "/teams/" + $team + "?api-version=6.0"
  $json = @{description=$description} | ConvertTo-Json
  $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json'
}

function CreateArea([string]$area, [string]$parent)
{
  if ($parent) {
    $resource = $azdoOrg + "/" + $azdoProject + "/_apis/wit/classificationNodes/areas/" + $parent + "?api-version=6.0"
    $friendlyArea = $parent + "\" + $area
  }
  else {
    $resource = $azdoOrg + "/" + $azdoProject + "/_apis/wit/classificationNodes/areas?api-version=6.0"
    $friendlyArea = $area
  }
  $json = @{name=$area} | ConvertTo-Json
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'
    Write-Host ""$friendlyarea -foregroundcolor "yellow" -NoNewline
    Write-Host " created"
  }
  catch {
    Write-Host ""$friendlyarea -foregroundcolor "yellow" -NoNewline
    Write-Host " already exists"
  }
}

function SetTeamArea([string]$team, [string]$area)
{
  $originalTeam = $team
  $team = $team -replace " ", "%20"
  $resource = $azdoOrg + "/" + $azdoProject + "/" + $team + "/_apis/Work/TeamSettings/TeamFieldValues?api-version=6.0"
  $json = '{ "defaultValue": "' + $azdoProject + '\\' + $area + '",
  "values": [
   {
      "value": "' + $azdoProject + '\\' + $area + '",
      "includeChildren": true
   }]
}'

  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json'
    # Write-Host "  Team" [$originalTeam]" area set to" [$area]
    Write-Host " Team " -NoNewline
    Write-Host $originalTeam -foregroundcolor "yellow" -NoNewline
    Write-Host " area set to " -NoNewline
    if ($area)
      { Write-Host $area -foregroundcolor "yellow" }
    else
      { Write-Host "(root)" -foregroundcolor "yellow" }
  }
  catch {
    Write-Host Error setting team [$originalTeam]" area set to" [$area]
    echo $_.Exception|format-list -force
  }
}

function CreateIteration([string]$iteration, [datetime]$startDate)
{
  $resource = $azdoOrg + "/" + $azdoProject + "/_apis/wit/classificationNodes/iterations?api-version=6.0"
  $json = @{name=$iteration} | ConvertTo-Json
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'
    Write-Host ""$iteration -foregroundcolor "yellow" -NoNewline
    Write-Host " created" -NoNewline
  }
  catch {
    Write-Host ""$iteration -foregroundcolor "yellow" -NoNewline
    Write-Host " already exists" -NoNewline
  }

  # Set Start and Finish dates

  $resource = $azdoOrg + "/" + $azdoProject + "/_apis/wit/classificationNodes/iterations/" + $iteration + "?api-version=6.0"
  $json = '{ "attributes": { 
    "startDate": "' + $startDate.ToUniversalTime().ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'") + '",
    "finishDate": "' + $startDate.AddDays(13).ToUniversalTime().ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'") + '"
   }
}'
  $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json'
  Write-Host ", setting dates"
}

function SetTeamIterations([string]$team)
{
  $originalTeam = $team

  # Save iteration IDs to array

  $iterations = New-Object System.Collections.ArrayList
  $resource = $azdoOrg + "/" + $azdoProject + '/_apis/wit/classificationNodes/iterations?$depth=2&api-version=6.0'
  $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Get
  $rootIteration = $response.identifier
  $response.children | ForEach-Object { $iterations.add($_.identifier) | out-null }

  # Set team's backlog iteration to root

  $team = $team -replace " ", "%20"
  $resource = $azdoOrg + "/" + $azdoProject + "/" + $team + "/_apis/Work/TeamSettings/?api-version=6.0"
  $json = '{ "backlogIteration": "' + $rootIteration + '" }'
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json'

    # Write-Host "  Team" [$originalTeam]" bacjkig iteration set to" [$rootIteration]

    Write-Host " Team " -NoNewline
    Write-Host $originalTeam -foregroundcolor "yellow" -NoNewline
    Write-Host " backlog iteration set to " -NoNewline
    Write-Host $rootIteration -foregroundcolor "yellow"
  }
  catch {
    Write-Host Error setting team [$originalTeam]" backlog iteration to" [$rootIteration]
    echo $_.Exception|format-list -force
  }

  # Set team's default iteration to root

  $team = $team -replace " ", "%20"
  $resource = $azdoOrg + "/" + $azdoProject + "/" + $team + "/_apis/Work/TeamSettings/?api-version=6.0"
  $json = '{ "defaultIteration": "' + $rootIteration + '" }'
  try {
    $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Patch -Body $json -ContentType 'application/json'

    # Write-Host "  Team" [$originalTeam]" default iteration set to" [$rootIteration]

    Write-Host " Team " -NoNewline
    Write-Host $originalTeam -foregroundcolor "yellow" -NoNewline
    Write-Host " default iteration set to " -NoNewline
    Write-Host $rootIteration -foregroundcolor "yellow"
  }
  catch {
    Write-Host Error setting team [$originalTeam]" default iteration to" [$rootIteration]
    echo $_.Exception|format-list -force
  }

  # Add individual iterations

  $team = $team -replace " ", "%20"
  $resource = $azdoOrg + "/" + $azdoProject + "/" + $team + "/_apis/Work/TeamSettings/Iterations?api-version=6.0"
  foreach ($iteration in $iterations) {
    $json = '{ "id":"' + $iteration + '"}'
    try {
      $response = Invoke-RestMethod -Uri $resource -headers $headers -Method Post -Body $json -ContentType 'application/json'

      # Write-Host "  Team" [$originalTeam]" iteration set to" [$iteration]

      Write-Host " Team " -NoNewline
      Write-Host $originalTeam -foregroundcolor "yellow" -NoNewline
      Write-Host " iteration set to " -NoNewline
      Write-Host $iteration -foregroundcolor "yellow"
    }
    catch {
      Write-Host Error setting team [$originalTeam]" iteration to" [$iteration]
      echo $_.Exception|format-list -force
    }
  }
}

Main