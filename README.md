## chaincode作为外部服务启动

```
Fabric v2.0支持将链码在Faric外部部署与执行以方便用户独立管理每个节点的代码运行环境。这有助于Kubernetes等Fabric云上部署链码。不再需要在每个节点构建和运行，链码现在可以作为一个服务运行，其生命周期在Fabric之外进行管理。此功能利用了Fabric v2.0外部构建器和启动器功能，使开发者能够通过程序扩展peer来构建、启动和发现链码。
```

本文将展示如何在Fabric2.3网络中将chaincode作为外部服务启动

### 1、clone 仓库

```bash
$ git clone https://github.com/iamlzw/running-chaincode-as-an-external-service.git

$ cd running-chaincode-as-an-external-service
```

### 2、修改core.yaml

仓库中的core.yaml是已经修改过的，所以这里无需修改，仅展示一下需要做哪些修改：

```bash
   ## 修改chaincode->externalBuilder下内容
   externalBuilders: 
         - path: /build/sampleBuilder
           name: external-sample-builder
           propagateEnvironment:
        #      - ENVVAR_NAME_TO_PROPAGATE_FROM_PEER
              - GOPROXY
```

### 3、修改docker-compose-net.yaml文件

仓库中的docker-compose-net.yaml是已经修改过的，所以这里无需修改，仅展示一下需要做哪些修改：

```yaml
 ## 修改peer0.org1.example.com与peer0.org2.example.com volumes，添加以下内容  
   volumes:
        - ./chaincode-external/sampleBuilder:/build/sampleBuilder
        - ./config/core.yaml:/etc/hyperledger/fabric/core.yaml
```

`chaincode-external/sampleBuilder`目录下是以下文件,具体作用参考https://hyperledger-fabric.readthedocs.io/en/latest/cc_launcher.html

```
chaincode-external/sampleBuilder
└── bin
    ├── build
    ├── detect
    └── release
```

### 2、启动测试网络

```bash
## 启动容器
$ ./start.sh
## orderer加入系统通道
$ ./join.sh
```

### 3、构建chaincode镜像

```bash
$ cd chaincode
$ docker build -t examplecc:1.0 .
## 查看镜像
$ docker ps | grep examplecc
```

### 4、打包合约

```bash
$ cd chaincode/packaging
```

`connection.json`是peer与chaincode连接的配置信息

```json
{
  "address": "examplecc.org1.example.com:9999", //合约地址
  "dial_timeout": "10s",
  "tls_required": false //是否开启peer与chaincode之间的tls通信，为了简单，这里设置为false，如果设置成true,那么需要生成相应的tls证书密钥
}
```

将`connection.json`打包为code.tar.gz

```bash
$ tar -czvf code.tar.gz connection.json
```

`metadata.json`是合约的一些元数据

```json
{
    "type": "external",//表示合约是外部服务的类型
    "label": "examplecc_1.0"
}
```

将`code.tar.gz`以及`metadata.json`打包为`examplecc.tar.gz`,

```bash
$ tar -czvf examplecc.tar.gz code.tar.gz connection.json
```

### 4、安装合约

在`peer0.org1.example.com`和`peer0.org2.example.com`上安装合约

```bash
$ ./install_chaincode.sh
```

![image-20220722224543730](https://user-images.githubusercontent.com/27334218/180473797-d251dbe1-fe6d-41c7-95ac-4bb71bcc000d.png)

输出的`a960cf49097b238dbfd0b448fd0f5f376cf2964ab6c78d840de83d7f2c8592a6`将用于之后启动合约容器以及实例化合约。

### 5、启动合约容器

```bash
$ cd chaincode
$ docker run -d --name examplecc.org1.example.com --hostname examplecc.org1.example.com --env-file chaincode.env --network=net_byfn chaincode/examplecc:1.0
```

### 6、实例化调用合约

```bash
$ ./init_chaincode.sh
```
![image-20220722225214418](https://user-images.githubusercontent.com/27334218/180473822-cb1b9874-69bd-470f-97ef-bd9e3381ad3c.png)

### 7、清理网络

```bash
$ ./stop.sh
$ docker rm -f examplecc.org1.example.com
$ docker system prune
```

### 总结

本文仅简单介绍以下将chaincode作为外部服务启动的步骤。为了减少一些配置，将peer与chaincode之间的tls通信设置为false，在生产上应当生成相应的tls密钥证书，开启peer与chaincode之间的tls通信，并在connection.json中配置相应的tls选项。

### 参考

https://hyperledger-fabric.readthedocs.io/en/latest/cc_service.html

https://github.com/hyperledger/fabric-samples/tree/v2.3.0/asset-transfer-basic/chaincode-external

https://dev.to/vanitas92/how-to-implement-hyperledger-fabric-external-chaincodes-within-a-kubernetes-cluster-34de

