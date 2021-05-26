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
![image](https://user-images.githubusercontent.com/27334218/119591063-8ed0da80-be08-11eb-806c-7723fe3109fc.png)

## 3.orderer join channel
```
./join.sh
```
![image](https://user-images.githubusercontent.com/27334218/119591151-b9229800-be08-11eb-8d7a-3b3c42cf63c8.png)

## 4.peer join channel and install chaincode
```
### echo pwd as PROJECT_PATH 
pwd
${PROJECT_PATH}
./init.sh ${PROJECT_PATH}
```
![image](https://user-images.githubusercontent.com/27334218/119591270-e2432880-be08-11eb-94fa-951dcf868b88.png)
![image](https://user-images.githubusercontent.com/27334218/119591420-22a2a680-be09-11eb-8491-5df32b6e8e86.png)


