# Report on Plugins.ps1

# List plugins and whether they're enabled or disabled by Select-Plugins.ps1

# Start of Settings
# List Enabled Plugins First
$ListEnabledPluginsFirst =$False
# End of Settings

$Title = "Report on Plugins"
$Author = "Phil Randal"
$PluginVersion = 1.0
$Header =  "Plugins Report"
$Comments = "Plugins in alphabetical order"
$Display = "Table"
$PluginCategory = "vCheck"

Push-Location
If ($pwd -notmatch '$plugins') {
  cd $ScriptPath\Plugins\
}
$plugins=get-childitem | where {$_.name -match '.*\.ps1(?:\.disabled|)$'} |
   Sort Name |
   Select Name, 
          @{Label="Plugin";expression={$_.Name -replace '(.*)\.ps1(?:\.disabled|)$', '$1'}},
          @{Label="Enabled";expression={$_.Name -notmatch '.*\.disabled$'}}

If ($ListEnabledPluginsFirst) {
  $Plugins | Select Plugin, Enabled |
    Sort -property @{Expression="Enabled";Descending=$true}, @{Expression="Plugin";Descending=$false}
  $Comments = "Plugins in alphabetical order, enabled plugins listed first"
} Else {
  $Plugins | Select Plugin, Enabled
}
Pop-Location
