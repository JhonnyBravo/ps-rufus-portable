param(
    [switch]$install,
    [switch]$uninstall
)

$dst="$(Split-Path -Parent $profile)\script"

if($install){
    $src_zip=(Resolve-Path "*.zip").Path
    unzip $src_zip -d .

    if($(Test-Path $dst) -eq $false){
        New-Item -ItemType directory $dst
    }

    $src_dir=$(echo $src_zip | sed -e "s/.zip//")
    $src=(Resolve-Path "${src_dir}/bin/*.exe").Path

    Copy-Item $src $dst
    Remove-Item $src_zip
    Remove-Item -Recurse $src_dir
}elseif($uninstall){
    if(Test-Path $dst){
        $path=(Resolve-Path "${dst}/phantomjs.exe").Path
        Remove-Item $path
    }
}


<#
.SYNOPSIS
パッケージをインストール / アンインストールします。

.DESCRIPTION
パッケージをインストール / アンインストールします。

.PARAMETER install
パッケージをインストールします。

.PARAMETER uninstall
パッケージをアンインストールします。
#>