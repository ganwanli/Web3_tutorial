# 北大肖臻老师的区块链课程

# 比特币

比特币中主要用到了密码学中两个功能：1.哈希 2.签名。密码学中的哈希函数（cryptographtic hash function） 

一、哈希函数 哈希函数主要有三个特性：1、碰撞特性（collision resistance）；2、隐秘性（Hiding）；3、谜题友好（puzzle friendly）。 

1、collision resistance collision resistance 即为输入两个输入值X，Y，经过哈希函数之后得到H(X)=H(Y)，即为哈希碰撞。利用哈希碰撞，可以检测对信息的篡改。假设输入x1，哈希值为H(x1)，此时很难找到一个x2，使得H(x1)=H(x2)。 

2、Hiding hiding 意思是哈希函数的计算过程是单向的，不可逆的。但前提要满足输入控件足够大，且分布均匀。通常我们在实际操作中会使用添加随机数的方法。假设给定一个输入值X，可以算出哈希值H(x)，但是不能从H(x)推出X。

 3、puzzle friendly 通常我们限定输出的哈希值在一定范围内，即H(block header + nonce) < target （block header是区块链的链头），这个确定链头范围的过程即为挖矿。

 二、签名 签名就相当于每个人的开户行账号。公钥签名，即开户账号，验证签名用私钥，即为账号密码。以此来确保比特币的安全传输。

# 以太坊

## modified Merkle-Paricia-Trie 

![image-20250618232142594](/Users/mac/Library/Application Support/typora-user-images/image-20250618232142594.png)



![image-20250618232823109](/Users/mac/Library/Application Support/typora-user-images/image-20250618232823109.png)



## 头结点的数据结构

![image-20250618233417423](/Users/mac/Library/Application Support/typora-user-images/image-20250618233417423.png)

parenthash：父节点

UncleHash：叔叔结点

Coinbase：旷工的地址

Root：状态树

TxHash：交易树

ReceiptHash：收据树

Bloom：提供高效的查询符合某种交易的查询结果

Difficulty：挖矿难度

Number：第几个

GasLimit：这个区块最大能交易的汽油费

GasUsed：这个区块总共用的汽油费

Time:挖矿的时间

Extra：

MixDigest：挖矿相关

Nonce：挖矿相关



## 区块的结构

![image-20250618234146791](/Users/mac/Library/Application Support/typora-user-images/image-20250618234146791.png)

header：指向block header的指针

uncles：指向叔父区块的header的指针数组

transactions：区块中的交易列表

![image-20250618234419669](/Users/mac/Library/Application Support/typora-user-images/image-20250618234419669.png)

## 新建块的代码

![image-20250619001953928](/Users/mac/Library/Application Support/typora-user-images/image-20250619001953928.png)

## Derivesha函数代码

![image-20250619002024432](/Users/mac/Library/Application Support/typora-user-images/image-20250619002024432.png)



## trie的代码：

![image-20250619002127167](/Users/mac/Library/Application Support/typora-user-images/image-20250619002127167.png)

## receipt的代码：

![image-20250619002157447](/Users/mac/Library/Application Support/typora-user-images/image-20250619002157447.png)

## CreateBloom、LogsBloom、bloom9

![image-20250619002300365](/Users/mac/Library/Application Support/typora-user-images/image-20250619002300365.png)

## BloomLookup

![image-20250619002828943](/Users/mac/Library/Application Support/typora-user-images/image-20250619002828943.png)



## 以太坊挖矿算法

### 1.生成16MB的cache

![image-20250619012817549](/Users/mac/Library/Application Support/typora-user-images/image-20250619012817549.png)

### 2.用cache生成1GB的DATASET

![image-20250619012952602](/Users/mac/Library/Application Support/typora-user-images/image-20250619012952602.png)

![image-20250619013056849](/Users/mac/Library/Application Support/typora-user-images/image-20250619013056849.png)

### 3.旷工挖矿函数，轻节点验证函数

![image-20250619013147752](/Users/mac/Library/Application Support/typora-user-images/image-20250619013147752.png)

### 挖矿主循环

![image-20250619013938321](/Users/mac/Library/Application Support/typora-user-images/image-20250619013938321.png)

## 区块难度公式

![image-20250619102216231](/Users/mac/Library/Application Support/typora-user-images/image-20250619102216231.png)

### 解释其中部分

![image-20250619102412908](/Users/mac/Library/Application Support/typora-user-images/image-20250619102412908.png)

### 难度炸弹

![image-20250619102940076](/Users/mac/Library/Application Support/typora-user-images/image-20250619102940076.png)

## 智能合约

![image-20250619132152094](/Users/mac/Library/Application Support/typora-user-images/image-20250619132152094.png)

HighestBidIncreased:拍卖的最高价增加

Pay2Beneficiary：

![image-20250619133221696](/Users/mac/Library/Application Support/typora-user-images/image-20250619133221696.png)



![image-20250619133647498](/Users/mac/Library/Application Support/typora-user-images/image-20250619133647498.png)

![image-20250619133722862](/Users/mac/Library/Application Support/typora-user-images/image-20250619133722862.png)

### 智能合约的创建

![image-20250619155938455](/Users/mac/Library/Application Support/typora-user-images/image-20250619155938455.png)

汽油费（gas）

![image-20250619160125507](/Users/mac/Library/Application Support/typora-user-images/image-20250619160125507.png)

Accountnonce：交易序号

Price：汽油费的单价

GasLimit：愿意支付汽油费最大值

Recipient：转账地址

Amount：转账数量

Payload：data域，存放调用的哪个函数，函数的参数取值

## 拍卖

![image-20250619164151457](/Users/mac/Library/Application Support/typora-user-images/image-20250619164151457.png)

![image-20250619164443912](/Users/mac/Library/Application Support/typora-user-images/image-20250619164443912.png)

![image-20250619170252946](/Users/mac/Library/Application Support/typora-user-images/image-20250619170252946.png)







# chainlink预言机课程

## 1.区块链基础知识

![image-20250620203750181](/Users/mac/Library/Application Support/typora-user-images/image-20250620203750181.png)





## 2.Solidity基本语法

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//comment : This is my first smart contract
contract HelloWord{
    bool boolVar_1 = true;
    bool boolVar_2 = false;

//256表示变量范围是0~2^256 uint和uint256等价的
    uint256 uintVar = 257;

    int256 uintVar2 = -1;

    bytes32 bytesVar = 'Hello World';
//string可以动态扩展开辟的内存空间，会导致内存的浪费
    string stringVar = "Hello World";

    address addressVar;


    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }

    Info[] infos;
//internal external public private
//view 只会对当前函数中的内容进行读取不做修改 
    /*
    1.storage 永久性存储
    2.memory  暂时存储，相当于变量，可以被修改（一般用于函数的入参）
    3.calldata  暂时存储，相当于常量，不能被修改（一般用于函数的入参）
    4.stack  局部临时存储
    5.codes  暂时存储，不会使用函数中的数据
    6.logs   暂时存储，不会使用函数中的数据
    */
    function sayHello() public view returns (string memory) {
        return addinfo(stringVar);
    }

    function setHelloWorld(string memory newString) public {
        stringVar = newString;
       
    }
// struct: 结构体
// array: 数组
// mapping: 映射


    function addinfo(string memory helloworldString)internal pure returns (string memory){
        return string.concat(helloworldString,"from Frank's contract.");
    }

}
```



![image-20250620215458488](/Users/mac/Library/Application Support/typora-user-images/image-20250620215458488.png)



### ①通过遍历数组

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//comment : This is my first smart contract
contract HelloWord{
 /*
    1.view : 读取数据，不修改数据
    2.pure: 只读，不修改数据
    3.constant：只读，不修改数据
    4.payable: 可以修改数据
        -> payable函数调用时会产生gas费。
        1.view和pure区别：前者不会产生gas费，后者会产生gas费。
    */
//storage 永久性存储
/*
    1.external : 对外部可见
    2.internal: 对内部可见
*/
//string可以动态扩展开辟的内存空间，会导致内存的浪费
    string stringVar = "Hello World";

    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }
//声明Info[]这个数组，默认的数据类型为storage，将会永久保存
    Info[] infos;


//通过入参的_id，遍历infos[]数组查找到这个结构体，将结构体的phrase传回作为addinfo()的入参，最后将结果返回。如果没找到这个id对应的结构体，那么返回默认的stringVar调用addinfo
    function sayHello(uint256 _id) public view returns (string memory) {
        for(uint256 i = 0 ; i < infos.length ; i ++){
            if(infos[i].id == _id){
                return addinfo(infos[i].phrase);
            }
        }
        return addinfo(stringVar);
    }

//new一个结构体数据，将结构体push到infos[]中永久保存
    function setHelloWorld(string memory newString, uint256 _id) public {
        Info memory info = Info(newString,_id,msg.sender);
        infos.push(info);
    }
// struct: 结构体
// array: 数组
// mapping: 映射


    function addinfo(string memory helloworldString)internal pure returns (string memory){
        return string.concat(helloworldString,"from Frank's contract.");
    }

}
```

### ②通过mapping查找

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//comment : This is my first smart contract
contract HelloWord{
 /*
    1.view : 读取数据，不修改数据
    2.pure: 只读，不修改数据
    3.constant：只读，不修改数据
    4.payable: 可以修改数据
        -> payable函数调用时会产生gas费。
        1.view和pure区别：前者不会产生gas费，后者会产生gas费。
    */
//storage 永久性存储
/*
    1.external : 对外部可见
    2.internal: 对内部可见
*/
//string可以动态扩展开辟的内存空间，会导致内存的浪费
    string stringVar = "Hello World";

    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }

    //声明infoMaping这个映射，默认的数据类型为storage，将会永久保存
    mapping(uint256 id => Info info) infoMaping;


//通过入参的_id，查找infoMapping这个映射查找到这个结构体，将结构体的phrase传回作为addinfo()的入参，最后将结果返回。如果没找到这个id对应的结构体，那么返回默认的stringVar调用addinfo
    function sayHello(uint256 _id) public view returns (string memory) {
        if(infoMaping[_id].addr == address(0x0)){
            return addinfo(stringVar);
        }else {
            return addinfo(infoMaping[_id].phrase);
        }
    }

//new一个结构体数据，将结构体push到infos[]中永久保存
    function setHelloWorld(string memory newString, uint256 _id) public {
        Info memory info = Info(newString,_id,msg.sender);
        infoMaping[_id] = info;
    }
// struct: 结构体
// array: 数组
// mapping: 映射


    function addinfo(string memory helloworldString)internal pure returns (string memory){
        return string.concat(helloworldString,"from Frank's contract.");
    }

}
```





### 工厂合约调用helloworld

```solidity
//SPDX-Liscense-Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


//1.引入其他的文件的合约，也可以直接从其他文件粘贴完整的合约代码到这个文件里
import { HelloWorld } from "./test.sol";
//2.也可以直接通过网络url调用
// import { HelloWorld } from "https://github.com/smartcontractkit/Web3_tutorial_Chinese/blob/main/lesson-2/HelloWorld.sol";
//3.通过包引入

contract HelloWorldFactory {
    HelloWorld hw;

    HelloWorld[] hws;

    function createHelloWorld() public {
        hw = new HelloWorld();
        hws.push(hw);
    }
    function getHelloWorldByIndex(uint256 _index) public view returns (HelloWorld){
        return hws[_index];
    }

    function callSayHelloFromFactory(uint256 _index,uint _id) 
    public 
    view
    returns (string memory){
        return hws[_index].sayHello(_id);
    }

    function callSetHelloWorldFromFactory(uint256 _index,string memory newstring,uint256 _id) public  {
        hws[_index].setHelloWorld(newstring , _id);
    }  
}
```



## 3.筹款和代币的实现demo

### ①FundMe.sol

```solidity
//SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/*
1.创建一个收款函数
2.记录投资人并且查看
3.在锁定期内，达到目标值，生产商可以提款
4.在锁定期内，没有达到目标值，投资人在锁定期以后可以退款
*/

contract FundMe {
    //声明fundersToAmount这个映射键值对，地址对应金额
    mapping (address => uint256) public fundersToAmount;

    //以合约名称为类型声明一个dataFeed，后面getChainlinkDataFeedLatestAnswer()会用到
    AggregatorV3Interface internal dataFeed;

    //设置最小投资金额,constant是常量关键字
    uint256 constant MIN_VALUE = 1 * 10 ** 18;//USD  10^18 

    //设置目标值
    uint256 constant TARGET = 10 * 10 ** 18;// 10^19

    //部署时间
    uint256 deploymentTimestamp;

    //锁定时间
    uint256 lockTime;

    address owner;

    bool public getFundSuccess = false;

    address erc20Addr;



    //创建一个收款函数,用户可以通过传参将以太币输入到筹款中
    function fund() external payable {
        require(convertEth2USD(msg.value) >= MIN_VALUE, "Fund must be at least 0.01 ETH");
        require(block.timestamp < deploymentTimestamp + lockTime, "Locktime has not passed yet") ;
        fundersToAmount[msg.sender] = msg.value;
    } 

    //构造函数，参数是筹款的锁定时间（秒），其中实现给ERC20的地址复制，owner的赋值，部署时间赋值和锁定时间
    constructor(uint256 _lockTime){
        //0x694AA1769357215DE4FAC081bf1f309aDC325306是以太币对应美元的地址
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        owner = msg.sender;
        deploymentTimestamp = block.timestamp;
        lockTime = _lockTime;
    }
    
    //获取最新的美元对应值
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            // uint80 roundID */,
            int answer,
            //uint startedAt*/,
            //uint timeStamp*/,
            //uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    //将以太币转换为美元计算，由于ERC20对应美元是10^8，所以需要除以10^8。所以单位对应就是 ETH=>USD
    function convertEth2USD(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return ethAmount * ethPrice/(10**8) ;
    }

		//owner提取筹款，先判断是否是owner再判断是否过了锁定期，筹款成功后会将msg.sender的amount置0和修改getFundSuccess标识
    function getFund() external onlyOwner windowClosed {
        require(convertEth2USD(address(this).balance) >= TARGET, "Target is not reached");

        // transfer: transfer ETH and revert if tx failed
        // payable(msg.sender).transfer(address(this).balance);//转移所有以太币给这个合约地址

        // send: transfer ETH and return false if failed
        // bool success = payable(msg.sender).send(address(this).balance);
        // require(success,"Failed to send Ether");

        // call: transfer ETH with data return value of function and bool 
        bool success;
        (success,) = payable(msg.sender).call{value : address(this).balance}("");
        require(success,"Failed to send Ether");
        fundersToAmount[msg.sender] = 0;
        getFundSuccess = true; // flag


    }
		//退还筹款，检查是否锁定期，检查是否没有达到筹款目标，检查用户的amount是否不为0，退款成功后将msg.sender的amount置0
    function reFund() external windowClosed{
        require(convertEth2USD(address(this).balance) < TARGET ,"Target is not reached");
        require(fundersToAmount[msg.sender] != 0 , "Nothing to reFund");

        bool success;
        (success, ) = payable(msg.sender).call{value : fundersToAmount[msg.sender]}("");
        require(success,"Failed to refund");
        fundersToAmount[msg.sender] = 0;
    }

		//一个modifier检查函数，检查是否过了锁定时间
    modifier windowClosed() {
        require(block.timestamp >= deploymentTimestamp + lockTime, "Locktime has passed") ;
        _;
    }
		//一个modifier检查函数，检查是否是owner
    modifier onlyOwner(){
        require(msg.sender == owner,"Not the Owner");
        _;
    }

		//转移拥有者权，必须是owner才能转移，转给入参地址
    function transferOwnership(address newOwner) public onlyOwner{
        owner = newOwner;
    }

    //跟新用户的amount，这个函数只能由ERC20的合约调用
    function setFunderToAmount(address funder,uint256 amountToUpdate) external {
        require(msg.sender == erc20Addr,"You don't have this permission to call this function");
        fundersToAmount[funder] = amountToUpdate;

    }

		//设置ERC20的合约地址
    function setErc20Addr(address _erc20Addr) public onlyOwner{
        // this is called by an authorized owner
        // to upgrade the address of msg.sender to newOwner
        erc20Addr = _erc20Addr;
    }

}


```



### ②FundTokenERC20

```solidity
//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

/*
 FundMe
 1. 让FundMe的参与者，基于mapping 来领取相应数量的通证
 2. 让FundMe的参与者，transfer 通证
 3. 在使用完成以后，需要burn 通证
*/

// ERC20 :  Fungible Token 用户之间可交换的通证
// ERC721: NFT = Non-Fungible Tokend  用户之间不可交换的通证
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./FundMe.sol";

contract FundTokenERC20 is ERC20 {
    FundMe fundMe;

    constructor(address _fundmeAddress) ERC20("FundTokenERC20", "FT"){
        fundMe = FundMe(_fundmeAddress);

    }

    // 给用户地址重置ERC20代币，1 Wei = 1  ERC
    // 先检查以太币是否大于需要对换的ERC20代币，再检查账户是否已经众筹完功了。确认后再进行对换。
    // 最后再更新fundMe的账户以太币
    function mint(uint256 amountToMint) public{
        require(fundMe.fundersToAmount(msg.sender) >= amountToMint,"You cannot mint this many tokens");
        require(fundMe.getFundSuccess(),"The fundme is not completed yet");
        _mint(msg.sender,amountToMint);
        fundMe.setFunderToAmount(msg.sender,fundMe.fundersToAmount(msg.sender) - amountToMint);
    }

    // 使用继承的ERC20的_burn函数销毁指定数量的代币
    // 首先检查是否有足够数量的代币，在检查是否已经众筹完成，确认后再进行销毁
    function claim(uint256 amountToClaim) public{
        // 检查用户是否有足够的 ERC20 代币被销毁，balanceOf是ERC20自带的函数，可以查询用户的余额
        require(balanceOf(msg.sender) >= amountToClaim,"You don't have enough ERC20 tokens");

        // 检查是否众筹成功完成
        require(fundMe.getFundSuccess(), "The fundme is not completed yet");

        // 销毁指定数量的代币
        _burn(msg.sender,amountToClaim);
    }


}
```



### ③部署到链上

1）复制FundTokenERC20.sol的合约地址，在Etherscan中搜索，在contract选项卡中显示的代码是乱码，在这里点击“varify and publish”

![image-20250624162036324](/Users/mac/Library/Application Support/typora-user-images/image-20250624162036324.png)

2）选择对应编译器类型、编译器版本和开源证件的版本，再继续

![image-20250624162115425](/Users/mac/Library/Application Support/typora-user-images/image-20250624162115425.png)



3）将需要部署上去的代码扁平化，需要注意的是，要把多个SPDX-License-Identifier：MIT注释删掉多余的，只能保留一个。

![image-20250624162342178](/Users/mac/Library/Application Support/typora-user-images/image-20250624162342178.png)

4）再将生成的_flattened的源码粘贴到代码框中

![image-20250624162627057](/Users/mac/Library/Application Support/typora-user-images/image-20250624162627057.png)



5）其他不用改点击下面的“Verify and Publish”

![image-20250624162705882](/Users/mac/Library/Application Support/typora-user-images/image-20250624162705882.png)



## 4.创建一个hardhat项目

```cmd
--进入项目文件夹
cd Web3_tutorial

--初始化
npm init

--将 Hardhat 作为开发依赖安装到项目中  --save-dev - 作为开发依赖安装
npm install hardhat --save-dev

--
npx hardhat

--初始化git
git init

--查看git状态
 git status
 
 --把所有的编辑的文件都添加到待提交列表里
  git add .
  
  --提交git，-m是添加备注信息
  git commit -m 'project init'
  
```



将remix中的FundMe粘贴过来，发现使用的外部的包报错

![image-20250622220026172](/Users/mac/Library/Application Support/typora-user-images/image-20250622220026172.png)

```cmd
  --将remix中的FundMe粘贴过来，发现使用的外部的包报错，安装对应的包
  npm install @chainlink/contracts --save-dev
```

同时，package.json的dependencies也会多出一条chainlink的包

![image-20250622220248661](/Users/mac/Library/Application Support/typora-user-images/image-20250622220248661.png)

安装完成后，编译整个项目

```cmd
 --安装好之后编译项目
  npx hardhat compile
  
```

![image-20250622220458870](/Users/mac/Library/Application Support/typora-user-images/image-20250622220458870.png)



### 部署

创建部署脚本

创建scripts文件夹，再创建deployFundMe.js的部署脚本文件

```javascript
// import ethers.js
// create main function
// execute main function

//引入这个包
const { ethers } = require("hardhat") 

//需要在函数前加上async关键字，因为要使用到await，await的作用是等待一个异步操作完成，然后获取结果。
async function main() {
    // create factory 
    const fundMeFactory = await ethers.getContractFactory("FundMe")
    console.log("contract deploying")
    // deploy contract from factory
    const fundMe = await fundMeFactory.deploy(300)
    // wait for contract to deploy
    await fundMe.waitForDeployment()
    console.log(`contract has been deployed successfully, contract address is ${fundMe.target}`);
}

// 捕获main函数的错误
main().then().catch((error) => {
    console.error(error)
    process.exit(0)
})
```

在hardhat.config.js中需要添加networks

```javascript
networks: {
    sepolia: {
      //Alchemy , Infura , QuickNode
      url: "https://eth-sepolia.g.alchemy.com/v2/dQM5ysm44BnbnDu4WhuKc",
      accounts: ["eb06fbc9c0856151a2bebd151cf6760878f7e2c856724a232a867dfd09379442"]
    }
  }
```

其中url是从Alchemy里获得的（alchemy.com），需要先注册账号，创建新的app

![image-20250622231303022](/Users/mac/Library/Application Support/typora-user-images/image-20250622231303022.png)

根据提示填写app名称

![image-20250622231325687](/Users/mac/Library/Application Support/typora-user-images/image-20250622231325687.png)

创建好app后，在网络那里可以找到https请求的地址，将地址复制粘贴到hardhat.config.js中的url中

![image-20250622231443230](/Users/mac/Library/Application Support/typora-user-images/image-20250622231443230.png)

再将metamask中的私钥粘贴到hardhat.config.js中的accounts中

