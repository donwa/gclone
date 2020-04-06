  
gclone  
====  
English [简体中文](https://github.com/donwa/gclone/blob/master/README_zh.md)  
   

A modified version of the [rclone](//github.com/rclone/rclone) 
Provide dynamic replacement sa file support for google drive operation


## installation  
```
bash <(wget -qO- https://git.io/gclone.sh)
```

```
// View version information
gclone version
```

## Instructions 
### 1.service_account_file_path Configuration   
add `service_account_file_path` Configuration.For dynamic replacement service_account_file(sa file). Replace configuration when `rateLimitExceeded` error occurs
`rclone.conf` example:  
```
[gc]
type = drive  
scope = drive  
service_account_file = /root/accounts/1.json  
service_account_file_path = /root/accounts/  
root_folder_id = root  
```
`/root/accounts/` Folder contains multiple access and edit permissions ***service account file(*.json)***.  
  
### 2.Support incoming id
If the original rclone is across team disks or shared folders, multiple configuration drive letters are required for operation.
gclone supports incoming id operation
```
gclone copy gc:{folde_id1} gc:{folde_id2}  --drive-server-side-across-configs
```
folde_id1 can be:Common directory, shared directory, team disk. 
  
```
gclone copy gc:{folde_id1} gc:{folde_id2}/media/  --drive-server-side-across-configs

```

```
gclone copy gc:{share_fiel_id} gc:{folde_id2}  --drive-server-side-across-configs
```
  

