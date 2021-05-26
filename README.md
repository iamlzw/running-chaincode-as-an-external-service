# deploy-fabric-without-sys-channel
this project deploy a fabric network without system channel

## 1.clone git repository
```
git clone https://github.com/iamlzw/deploy-fabric-without-sys-channel.git
```
## 2.start fabric network
```
cd deploy-fabric-without-sys-channel
./start.sh
```
## 3.orderer join channel
```
./join.sh
```
## 4.peer join channel and install chaincode
```
### echo pwd as PROJECT_PATH 
pwd
${PROJECT_PATH}
./init.sh ${PROJECT_PATH}
```
![image](https://user-images.githubusercontent.com/27334218/119590316-1ae20280-be07-11eb-88f1-1e19b59b8509.png)

