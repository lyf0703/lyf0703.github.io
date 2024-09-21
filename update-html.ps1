# update-html.ps1

# �����ļ����б�1 �� 5��
$folders = 1..5

# ��ʼ��һ���չ�ϣ��
$imagesHash = @{}

foreach ($folder in $folders) {
    # ���ļ�������ת��Ϊ�ַ���
    $folderKey = "$folder"

    # ��ȡÿ���ļ����е�PNGͼƬ
    $images = Get-ChildItem -Path "./$folder" -Filter "*.PNG" | Select-Object -ExpandProperty Name

    # ȷ�� $images �����飬��ʹֻ��һ��Ԫ��
    if (-not ($images -is [System.Array])) {
        $images = @($images)
    }

    # ��ӵ���ϣ���У�ʹ���ַ�����
    $imagesHash[$folderKey] = $images
}

# ����ϣ��ת��ΪJSON������
$imagesHash | ConvertTo-Json -Depth 3 | Set-Content -Path "images.json" -Encoding UTF8

Write-Host "images.json �����ɡ�"
