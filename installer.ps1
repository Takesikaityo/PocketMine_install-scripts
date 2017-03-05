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
				#throw $_
			}
		}
		try
		{
			$DownloadPath = Join-Path $DownloadFolder $FileName -ErrorAction Stop
		}
		catch
		{
			#throw $_
		}
	}
	process
	{
		Invoke-WebRequest -Uri $Uri -OutFile $DownloadPath #-Verbose -PassThru
	}
	end
	{
		#Get-Item $DownloadPath
	}
}

echo よー来たな。StarrySky インストーラーへようこそ。言語はオーサカ共和国語のみや。注意せいや。
echo StarrySkyインストールするで
if(Test-Path ".\tmp\src.zip"){
	Remove-Item ".\tmp\src.zip" -Recurse
}else{
}
Invoke-DownloadFile -Uri "https://github.com/StarrySky-PE/StarrySky/archive/master.zip" -DownloadFolder ".\tmp\" -FileName "src.zip"
Expand-Archive ".\tmp\src.zip" ".\"
Move-Item ".\StarrySky-master\src" ".\" -Passthru
Move-Item ".\StarrySky-master\start.cmd" ".\" -Passthru
Move-Item ".\StarrySky-master\start.ps1" ".\" -Passthru
Remove-Item ".\StarrySky-master" -Recurse

$os = Get-WmiObject -Class Win32_OperatingSystem
if($os.OSarchitecture -match "64"){
echo このosは64bitです。
if(Test-Path ".\tmp\bin.zip"){
	Remove-Item ".\tmp\bin.zip" -Force
    echo 前のTmpファイルがあったからな削除したで。
}else{
}
Invoke-DownloadFile -Uri "https://github.com/Takesikaityo/PocketMine_Bin_win_x64/archive/master.zip" -DownloadFolder ".\tmp\" -FileName "bin.zip"
if(Test-Path ".\bin"){
	Remove-Item ".\bin" -Recurse
    echo 前のBinファイルがあったからな削除したで。
}else{
}
if(Test-Path ".\PocketMine_Bin_win_x64-master"){
	Remove-Item ".\PocketMine_Bin_win_x64-master" -Recurse
    echo 前の一時展開ファイルがあったからな削除したで。
}else{
}
Expand-Archive ".\tmp\bin.zip" ".\"
Move-Item ".\PocketMine_Bin_win_x64-master\bin" ".\" -Passthru
Remove-Item ".\PocketMine_Bin_win_x64-master" -Recurse
}else{
if(Test-Path ".\tmp\bin.zip"){
	Remove-Item ".\tmp\bin.zip" -Recurse
    echo 前のTmpファイルがあったからな削除したで。
}else{
}
Invoke-DownloadFile -Uri "https://github.com/Takesikaityo/PocketMine_Bin_win_x32/archive/master.zip" -DownloadFolder "tmp\" -FileName "bin.zip"
if(Test-Path ".\bin"){
	Remove-Item ".\bin" -Recurse
    echo 前のBinファイルがあったからな削除したで。
}else{
}
if(Test-Path ".\PocketMine_Bin_win_x32-master"){
	Remove-Item ".\PocketMine_Bin_win_x32-master" -Recurse
    echo 前の一時展開ファイルがあったからな削除したで。
}else{
}
Expand-Archive ".\tmp\bin.zip" ".\"
Move-Item ".\PocketMine_Bin_win_x32-master\bin" ".\"
Remove-Item ".\PocketMine_Bin_win_x32-master" -Recurse
}
