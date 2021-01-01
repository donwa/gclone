  
gclone  
====  
简体中文 [English](https://github.com/tomyummmm/gclone/blob/master/README.md)   
   
   
一个[rclone](//github.com/rclone/rclone)  的修改版.  
为Google Drive操作增加自动切换账户和命令行根目录id操作支持.  
其他功能与原版rclone相同.  


```
// 查看版本信息
gclone version
```

## 操作说明  
### 1.service_account_file_path配置   
添加`service_account_file_path`配置.用于动态替换service_account_file(sa文件).实现`rateLimitExceeded`错误时,替换当前用户，绕过750G限制.  

`rclone.conf`文件示例:  
```
[gc]
type = drive  
scope = drive  
service_account_file = /root/accounts/1.json  
service_account_file_path = /root/accounts/  <------- (核心)添加了这个配置  
root_folder_id = root  
```
其中`/root/accounts/`文件夹中存放了多个访问和编辑权限相同的***service account file (x.json)***.  
配置完成后.只要是`gclone`对`gc:`进行操作,出现`rateLimitExceeded`错误时,都会自动更换sa文件,实现无缝绕过限制.  
  
  
  
### 2.命令行根目录id  
原版rclone如果跨团队盘或者共享文件夹,需要多个配置盘符用于操作.  
gclone支持根目录`id`操作.共享目录和团队盘应该带`--drive-server-side-across-configs`
```
gclone copy gc:{目录1的id} gc:{目录2的id}  --drive-server-side-across-configs
```
目录id可以是:普通目录，共享目录，团队盘.  
  
支持{目录id}后,跟后续路径  
```
gclone copy gc:{共享目录id} gc:{团队盘id}/media/  --drive-server-side-across-configs

```

### 3.直接拷贝单文件id  
`id`操作.共享目录和团队盘应该带`--drive-server-side-across-configs`
```
gclone copy gc:{共享文件的id} gc:{目录2的id}  --drive-server-side-across-configs
```
  
支持{目录id}后,跟后续路径  
```
gclone copy gc:{共享文件的id} gc:{团队盘id}/media/  --drive-server-side-across-configs

```
