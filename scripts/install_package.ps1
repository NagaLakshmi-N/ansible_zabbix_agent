#!powershell
# (c) 2014, Trond Hindenes <trond@hindenes.com>, and others
#
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# WANT_JSON
# POWERSHELL_COMMON


param(
   [String] $package_name,
   [String] $installation_filepath,
   [String] $config_filepath,
   [String] $process_name
)

#stop and fail script when a command fails
$errorActionPreference="Stop"

if (${env:programfiles(x86)})
  { 
  echo  $package_path
  $package_path = join-path "${env:programfiles(x86)}" "$package_name" }
else
  { echo $package_path
  $package_path = join-path "${env:programfiles}" "$package_name" }

if (test-path "HKLM:\SYSTEM\ControlSet001\Services\$package_name")
{

  $process = Get-Process $process_name -ErrorAction SilentlyContinue
  if ($process) {
    $process.CloseMainWindow()
    if (!$process.HasExited) {
      $process | Stop-Process -Force
    }
  }

   Write-Output  "$installation_filepath"
   Write-Output "$package_name already installed. Skipping script"
   exit 0
}

cmd /c "$installation_filepath" --config "$config_filepath" --install
