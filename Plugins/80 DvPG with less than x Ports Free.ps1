# Start of Settings 
# Distributed vSwitch PortGroup Ports Left
$DvSwitchLeft = 10
# End of Settings

# Changelog
# 1.0 - Inital release
# 1.1 - Performance improvements

$ImpactedDVS = @() 

Foreach ($PortGroup in (Get-VDPortgroup | where {$_.IsUplink -ne 'True' -and $_.PortBinding -ne 'Ephemeral'} )) {
	$OpenPorts = ($Portgroup.NumPorts - (($Portgroup.ExtensionData.VM).Count))

	If ($OpenPorts -lt $DvSwitchLeft) {
		$myObj = "" | select VirtualSwitch,Name,OpenPorts
		$myObj.VirtualSwitch = $PortGroup.VirtualSwitch.Name
		$myObj.Name = $PortGroup.Name
		$myObj.OpenPorts = $OpenPorts
		$ImpactedDVS += $myObj
	}
}

$ImpactedDVS

$Title = "Checking Distributed vSwitch Port Groups for Ports Free"
$Header =  "Distributed vSwitch Port Groups with less than $vSwitchLeft Port(s) Free: $(@($ImpactedDVS).Count)"
$Comments = "The following Distributed vSwitch Port Groups have less than $vSwitchLeft left"
$Display = "Table"
$Author = "Kyle Ruddy, Sam McGeown"
$PluginVersion = 1.1
$PluginCategory = "vSphere"
