# update-html.ps1

# 定义文件夹列表（1 到 5）
$folders = 1..5

# 初始化一个空哈希表
$imagesHash = @{}

foreach ($folder in $folders) {
    # 将文件夹名称转换为字符串
    $folderKey = "$folder"

    # 获取每个文件夹中的PNG图片
    $images = Get-ChildItem -Path "./$folder" -Filter "*.PNG" | Select-Object -ExpandProperty Name

    # 确保 $images 是数组，即使只有一个元素
    if (-not ($images -is [System.Array])) {
        $images = @($images)
    }

    # 添加到哈希表中，使用字符串键
    $imagesHash[$folderKey] = $images
}

# 将哈希表转换为JSON并保存
$imagesHash | ConvertTo-Json -Depth 3 | Set-Content -Path "images.json" -Encoding UTF8

Write-Host "images.json 已生成。"
