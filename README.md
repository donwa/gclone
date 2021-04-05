  
gclone  
====  
English [简体中文](https://github.com/tomyummmm/gclone/blob/master/README_zh.md)  
   

A modified version of the [rclone](//github.com/rclone/rclone) 
Provide dynamic replacement SA file support for google drive operation.
All other functions are the same as rclone.

This version includes PR#38 in original gclone [filepath end with slash /](https://github.com/donwa/gclone/pull/38)


```
// View version information
gclone version
```

## Instructions 
### 1. service_account_file_path Configuration   
Add `service_account_file_path` Configuration. For dynamic replacement service_account_file(SA file). Replaces SA file when `rateLimitExceeded` error occurs to bypass 750GB limit.  

`rclone.conf` example:  
```
[gc]
type = drive  
scope = drive  
service_account_file = /root/accounts/1.json  
service_account_file_path = /root/accounts/  <------- (Important) Add this in configuration 
root_folder_id = root  
```
`/root/accounts/` Folder contains multiple access and edit permissions ***service account file (x.json)***.  
Once set up, when `gclone` sees `rateLimitExceeded` error, it will automatically change SA file, seamlessly bypassing the limit in real-time.  

### 2. Use gc-local.bat provided for ease of use and operation of gclone. (Windows only)
Read the instructions [here](https://telegra.ph/How-to-use-GC-Remote-and-Localbat-08-21) written by me.  
You can find the original [repository](https://github.com/tomyummmm/gclone-batch-file) written by me.

## Features
### 1. Supports Folder ID
If the original rclone is across team disks or shared folders, multiple configuration drive letters are required for operation.

gclone supports Folder ID operations
```
gclone copy gc:{folder_id1} gc:{folder_id2}  --drive-server-side-across-configs
```
folder_id1 can be: common directory, shared directory, team drive. 
  
```
gclone copy gc:{folder_id1} gc:{folder_id2}/media/  --drive-server-side-across-configs
```

```
gclone copy gc:{shared_folder_id} gc:{folder_id2}  --drive-server-side-across-configs
```
  
### 2. Direct Copy with file ID
`id` operations: common directory, shared directory, team drive.  
```
gclone copy gc:{shared_file_id} gc:{folder_id2}  --drive-server-side-across-configs
```

Supports {Folder ID} proceeding filepaths
```
gclone copy gc:{shared_file_id} gc:{Team Drive ID}/media/  --drive-server-side-across-configs
```



## Code edited
### All additional code that makes gclone run is encased. Most of the code edited is in drive.go inside \backend\drive
```
//------------------------------------------------------------
// 如果存在 ServiceAccountFilePath,调用 changeSvc, 重试
// If ServiceAccountFilePath exists, call changeSvc and try again
if(f.opt.ServiceAccountFilePath != ""){
	f.waitChangeSvc.Lock()
	f.changeSvc()
	f.waitChangeSvc.Unlock()
	return true, err
}
//------------------------------------------------------------
```