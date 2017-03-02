function Invoke-DownloadFile{
	[CmdletBinding()]
	param(
		[parameter(Mandatory,position=0)]
		[string]
		$Uri,

		[parameter(Mandatory,position=1)]
		[string]
		$DownloadFolder,

		[parameter(Mandatory,position=2)]
		[string]
		$FileName
	)
	begin
	{
		If (-not(Test-Path $DownloadFolder))
		{
			try
			{
				New-Item -ItemType Directory -Path $DownloadFolder -ErrorAction stop
			}
			catch
			{
				throw $_
			}
		}
		try
		{
			$DownloadPath = Join-Path $DownloadFolder $FileName -ErrorAction Stop
		}
		catch
		{
			throw $_
		}
	}
	process
	{
		Invoke-WebRequest -Uri $Uri -OutFile $DownloadPath -Verbose -PassThru
	}
	end
	{
		Get-Item $DownloadPath
	}
}

$os = Get-WmiObject -Class Win32_OperatingSystem
if($os.OSarchitecture -match "64"){
if(Test-Path ".\tmp\bin.zip"){
	Remove-Item ".\tmp\bin.zip" -Force
    echo �O��Tmp�t�@�C��������������ȍ폜�����ŁB
}else{
}
Invoke-DownloadFile -Uri "https://github.com/Takesikaityo/PocketMine_Bin_win_x64/archive/master.zip" -DownloadFolder "tmp\" -FileName "bin.zip"
if(Test-Path ".\bin"){
	Remove-Item ".\bin" -Recurse
    echo �O��Bin�t�@�C��������������ȍ폜�����ŁB
}else{
}
if(Test-Path ".\PocketMine_Bin_win_x64-master"){
	Remove-Item ".\PocketMine_Bin_win_x64-master" -Recurse
    echo �O�̈ꎞ�W�J�t�@�C��������������ȍ폜�����ŁB
}else{
}
Expand-Archive ".\tmp\bin.zip" ".\"
Move-Item ".\PocketMine_Bin_win_x64-master\bin" ".\"
}else{
if(Test-Path ".\tmp\bin.zip"){
	Remove-Item ".\tmp\bin.zip" -Recurse
    echo �O��Tmp�t�@�C��������������ȍ폜�����ŁB
}else{
}
Invoke-DownloadFile -Uri "https://github.com/Takesikaityo/PocketMine_Bin_win_x32/archive/master.zip" -DownloadFolder "tmp\" -FileName "bin.zip"
if(Test-Path ".\bin"){
	Remove-Item ".\bin" -Recurse
    echo �O��Bin�t�@�C��������������ȍ폜�����ŁB
}else{
}
if(Test-Path ".\PocketMine_Bin_win_x32-master"){
	Remove-Item ".\PocketMine_Bin_win_x32-master" -Recurse
    echo �O�̈ꎞ�W�J�t�@�C��������������ȍ폜�����ŁB
}else{
}
Expand-Archive ".\tmp\bin.zip" ".\"
Move-Item ".\PocketMine_Bin_win_x32-master\bin" ".\"
}