# generate-images.ps1
# 该脚本扫描当前目录下的所有文件夹，获取其中的图片文件，并生成 images.json 文件。

$ImageExtensions = @(".jpg", ".jpeg", ".png", ".gif")
$Folders = Get-ChildItem -Directory
$ImagesData = @{}

foreach ($Folder in $Folders) {
    $FolderName = $Folder.Name
    $ImageFiles = Get-ChildItem -Path $Folder.FullName -File | Where-Object {
        $ImageExtensions -contains $_.Extension.ToLower()
    }

    # 创建一个空的图片路径数组
    $ImageFilePaths = @()

    foreach ($ImageFile in $ImageFiles) {
        # 生成相对路径，使用正斜杠
        $RelativePath = ($FolderName + '/' + $ImageFile.Name)
        $ImageFilePaths += $RelativePath
    }

    # 将文件夹名称和对应的图片数组添加到哈希表中
    $ImagesData[$FolderName] = $ImageFilePaths
}

# 将哈希表转换为 JSON 格式
$Json = $ImagesData | ConvertTo-Json -Depth 5

# 将 JSON 写入 images.json 文件，使用 UTF8 无 BOM 编码
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
[System.IO.File]::WriteAllText("images.json", $Json, $Utf8NoBomEncoding)

Write-Host "images.json 已生成。"
