# generate-images.ps1
# �ýű�ɨ�赱ǰĿ¼�µ������ļ��У���ȡ���е�ͼƬ�ļ��������� images.json �ļ���

$ImageExtensions = @(".jpg", ".jpeg", ".png", ".gif")
$Folders = Get-ChildItem -Directory
$ImagesData = @{}

foreach ($Folder in $Folders) {
    $FolderName = $Folder.Name
    $ImageFiles = Get-ChildItem -Path $Folder.FullName -File | Where-Object {
        $ImageExtensions -contains $_.Extension.ToLower()
    }

    # ����һ���յ�ͼƬ·������
    $ImageFilePaths = @()

    foreach ($ImageFile in $ImageFiles) {
        # �������·����ʹ����б��
        $RelativePath = ($FolderName + '/' + $ImageFile.Name)
        $ImageFilePaths += $RelativePath
    }

    # ���ļ������ƺͶ�Ӧ��ͼƬ������ӵ���ϣ����
    $ImagesData[$FolderName] = $ImageFilePaths
}

# ����ϣ��ת��Ϊ JSON ��ʽ
$Json = $ImagesData | ConvertTo-Json -Depth 5

# �� JSON д�� images.json �ļ���ʹ�� UTF8 �� BOM ����
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
[System.IO.File]::WriteAllText("images.json", $Json, $Utf8NoBomEncoding)

Write-Host "images.json �����ɡ�"
