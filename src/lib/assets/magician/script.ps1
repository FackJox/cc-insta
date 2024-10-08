# Get the current directory name
$dirName = Split-Path -Leaf (Get-Location)

# Initialize a counter
$counter = 1

# Get all .png files in the current directory
Get-ChildItem -Filter *.png | ForEach-Object {
    # Create the new file name
    $newName = "{0}_{1:D2}.png" -f $dirName, $counter

    # Rename the file
    Rename-Item $_.FullName -NewName $newName

    # Increment the counter
    $counter++
}
