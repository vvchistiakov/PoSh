<#
.SYNOPSIS
Get configuration file
.DESCRIPTION
Read config file and create hash bank of items
.PARAMETER path
Path to configure file
.INPUTS
You can pipe path to cfg
.OUTPUTS
System.Collections.Hashtable. Get-Config return hash bank of items: [section][item]=value
#>
function Get-Config {
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $true, ValueFromPipeline)]
		[string]$path
	)
	process {
		$hash = @{};
		switch -regex  (Get-Content -Path $path) {
			# create section
			"^\[(.+)\]$" {
				$section = $matches[1]
				$hash[$section] = @{};
			}
			# add item=value to section
			"^(.+)=(.+)$" {
				$name = $matches[1];
				$value = $matches[2];
				$hash[$section][$name] = $value;
			}	
		}
		return $hash;
	}
}