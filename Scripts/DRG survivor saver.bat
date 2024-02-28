# Navigate to the folder containing the files you want to compress
cd "C:\Users\dead_\AppData\LocalLow\Funday Games\DRG Survivor"

# Create a zip file with the current date and the desired name
Compress-Archive -Path . -DestinationPath "$(Get-Date -Format "yyyy-MM-dd")_DRG_Survivor.zip"

# Move the zip file to the desired destination
Move-Item -Path "$(Get-Date -Format "yyyy-MM-dd")_DRG_Survivor.zip" -Destination "C:\Users\dead_\Desktop\Code\Vault\Savefiles"