#check for Raspberry Pi Pico:
try{$drive = (Get-Volume -FriendlyName RPI-RP2 -erroraction stop)}
catch{
  "Couldn't find Ducky candidate!"
  Read-Host -Prompt "`r`nPress Enter to exit"
  Exit
}

$dLetter = $drive.DriveLetter
Write-Host "Ducky candidate found, Starting AutoSetup:"
$root = $dLetter + ":\"

#copy circuitpython.uf2 to ducky:
Write-Host "Copying circuitpython.uf2..."
Copy-Item -Path adafruit-circuitpython-raspberry_pi_pico-en_US-7.0.0.uf2 -Destination $root
Write-Host "Waiting for Ducky to reboot..."
$drive = $null
Do{
  Start-Sleep -Milliseconds 500
  try{$drive = (Get-Volume -FriendlyName CIRCUITPY -erroraction stop)}
  catch{}
}While($drive -eq $null)

Write-Host "Ducky is up!"

$dLetter = $drive.DriveLetter
$root = $dLetter + ":\"

#copy hid folder:
Write-Host "Copying hid library..."
Copy-Item -Path adafruit_hid -Destination ($root + "lib\adafruit_hid") -recurse -force

#copy code.py (duckyinpython.py):
Write-Host "Copying code.py duckyinpython.py..."
Copy-Item -Path code.py -Destination ($root + "code.py")

Write-Host "ALMOST DONE! Copy your payload.dd file to start hacking!"

Read-Host -Prompt "`r`nPress Enter to exit"