# Create a DS Entry object fo the domain path.
[adsi]"LDAP://DC=tachack,DC=local"

[adsi]""

$DCObj = [adsi]"LDAP://OU=Domain Controllers,DC=tachack,DC=local"
$DCObj | Get-Member

# Working with ADSI COM object
$DCObj.psbase | gm
$DCObj.psbase | gm -Force

$DCObj.psbase.get_path()
$DCObj.psbase.get_parent()


# System.DirectoryServices.ActiveDirectory Namespace
[System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

[System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain()

[System.DirectoryServices.ActiveDirectory.Domain]::GetDomain()  

# Searcher 
$searcher = [adsisearcher]"objectcategory=computer"  
$searcher | gm

# SPN Search
$filter = '(&(objectCategory=computer)(servicePrincipalName=LDAP*))'
$searcher = [adsisearcher]$filter
$searcher.PageSize = 1000
$searcher.FindAll() 

