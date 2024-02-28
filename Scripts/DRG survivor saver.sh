# Navigate to the folder containing the files you want to compress
cd "C:\Users\dead_\AppData\LocalLow\Funday Games\DRG Survivor"

# Create a zip file with the current date and the desired name
zip -r "$(date +%Y-%m-%d)_DRG_Survivor.zip" .

# Move the zip file to the desired destination
mv "$(date +%Y-%m-%d)_DRG_Survivor.zip" "C:\Users\dead_\Desktop\Code\Vault\Savefiles"
