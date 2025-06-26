# Chainlink预言机的B站课程

## 1.区块链基础知识

![Screenshot 2025-06-26 at 10.12.52](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/Screenshot 2025-06-26 at 10.12.52.png)



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

![image-20250626102415605](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250626102415605.png)



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

![image-20250624162036324](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250624162036324.png)



2）选择对应编译器类型、编译器版本和开源证件的版本，再继续

![image-20250624162115425](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250624162115425.png)



3）将需要部署上去的代码扁平化，需要注意的是，要把多个SPDX-License-Identifier：MIT注释删掉多余的，只能保留一个。

![image-20250624162342178](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250624162342178.png)



4）再将生成的_flattened的源码粘贴到代码框中







![image-20250624162627057](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250624162627057-0904875.png)



5）其他不用改点击下面的“Verify and Publish”

![image-20250624162705882](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250624162705882.png)



## 4.hardhat项目

### ①创建hardhat项目

shell命令

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

![image-20250622220026172](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250622220026172.png)

```cmd
  --将remix中的FundMe粘贴过来，发现使用的外部的包报错，安装对应的包
  npm install @chainlink/contracts --save-dev
```

同时，package.json的dependencies也会多出一条chainlink的包

![image-20250622220248661](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250622220248661.png)

安装完成后，编译整个项目

```cmd
 --安装好之后编译项目
  npx hardhat compile
  
```

![image-20250622220458870](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250622220458870.png)



### ②创建部署脚本

创建scripts文件夹，再创建**deployFundMe.js**的部署脚本文件

```javascript
// import ethers.js
// create main function
// execute main function

//引入这个ethers.js包  docs.ethers.org
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



### ③配置网络

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

![image-20250622231303022](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250622231303022.png)

根据提示填写app名称

![image-20250622231325687](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250622231325687.png)

创建好app后，在网络那里可以找到https请求的地址，将地址复制粘贴到hardhat.config.js中的url中

![image-20250622231443230](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250622231443230.png)

再将metamask中的私钥粘贴到hardhat.config.js中的accounts中

命令部署

```shell
npx hardhat run scripts/deployFundMe.js --network sepolia
```

如果部署成功可以看到以下输出

```
mac@MacBook-Pro-3 Web3_tutorial % npx hardhat run scripts/deployFundMe.js --network sepolia
contract deploying
contract has been deployed successfully, contract address is 0xBf1C7f050E07018b102f6EF81282969D0602951c
```

为了防止敏感信息的泄露，在根目录创建一个文件.env在里面配置信息

```
SEPOLIA_URL = https://eth-sepolia.g.alchemy.com/v2/dQM5ysm44BnbnDu4WhuKc
SEPOLIA_PRIVATE_KEY = eb06fbc9c0856151a2bebd151cf6760878f7e2c856724a232a867dfd09379442
```

要在中引用.env的信息，需要安装dotenv工具

```
npm install --save-dev dotenv
```

安装加密的env工具包

```
npm install --save-dev @chainlink/env-enc
```

设置加密变量

```
--先设置env-enc的密码
mac@MacBook-Pro-3 Web3_tutorial % npx env-enc set-pw
Enter the password (input will be hidden):
***********

--输入设置加密变量，然后根据提示先输入变量名再输入变量值
mac@MacBook-Pro-3 Web3_tutorial % npx env-enc set
```

完成后会新增一个.env.enc的文件

在hardhat.config.js文件中添加以下代码替换明文的敏感信息

```javascript
require("@chainlink/env-enc").config();
const SEPOLIA_URL = process.env.SEPOLIA_URL
const PRIVATE_KEY = process.env.SEPOLIA_PRIVATE_KEY

//在把明文显示的地方改为变量
url: SEPOLIA_URL,
      accounts: [PRIVATE_KEY]
```



### ④Verify验证

在hardhat官网上的插件可以找到如何安装并应用Verify插件

1）安装hardhat的Verify插件

```cmd
npm install --save-dev @nomicfoundation/hardhat-verify
```

2添加代码到hardhat.config.js

```javascript
require("@nomicfoundation/hardhat-verify");
```

3）用命令行执行验证

```cmd
npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"
-- mainnet 网络名称
-- DEPLOYED_CONTRACT_ADDRESS  合约的地址
-- "Constructor argument 1" 参数
```

4）用脚本执行验证

a.在Etherscan上申请apikey(需要先登录)

![image-20250625094919521](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250625094919521.png)

b.env-enc设置ETHERSCAN_API_KEY

c.增加hardhat.config.js代码

```javascript
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY


module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111
    }
  },
  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_API_KEY
    }
  }
};
```

d.增加deployFundMe.js脚本

```javascript
//添加到main函数的打印合约被成功部署的下面

// verify fundme
//检查chainId是否是sepolia（11155111）和是否有ETHERSCAN_API_KET
    if(hre.network.config.chainId == 11155111 && process.env.ETHERSCAN_API_KEY) {
        console.log("Waiting for 5 confirmations")
      //部署之后需要等待5个确认后再开始执行验证操作
        await fundMe.deploymentTransaction().wait(5) 
      //执行验证
        await verifyFundMe(fundMe.target, [300])
    } else {
      //如果不是sepolia，就跳过验证
        console.log("verification skipped..")
    }

//执行验证
async function verifyFundMe(fundMeAddr, args) {
  //在命令行中执行verify
    await hre.run("verify:verify", {
        address: fundMeAddr,
        constructorArguments: args,
      });
}
```



### ⑤合约交互脚本

在deployFundMe.js中添加如下代码

```javascript
//init 2 accounts
    const [firstAccount,secondAccount] = await ethers.getSigners()
    console.log(`2 accounts are ${firstAccount.address} and ${secondAccount.address}`)

    // fund contract with first account
    const fundTx = await fundMe.fund({value : ethers.parseEther("0.01")})
    await fundTx.wait()

    //check balance of contract
    const balanceOfContractAfterFirstFund = await ethers.provider.getBalance(fundMe.target)
    console.log(`Balance of the contract is ${balanceOfContractAfterFirstFund}`)

    //fund contract with second account
    const fundTxWithSecondAccount = await fundMe.connect(secondAccount).fund({value : ethers.parseEther("0.01")})
    await fundTxWithSecondAccount.wait()

    //check balance of contract
    const balanceOfContractAfterSecondFund = await ethers.provider.getBalance(fundMe.target)
    console.log(`Balance of the contract is ${balanceOfContractAfterSecondFund}`)
```

### ⑥自定义task

a.新增tasks目录，在其下新增三个js文件

deploy-fundme.js

```javascript
const { task } = require("hardhat/config")

//task("task名称","task描述").setAction(async(taskArgs：命令行传入的参数,hre：Hardhat Runtime Environment（运行时环境）))
task("deploy-fundme", "deploy and verify fundme conract").setAction(async(taskArgs, hre) => {
     // 以下是和deployFundMe.js一样的具体合约部署部分的代码
} )

//这里需要提出来
async function verifyFundMe(fundMeAddr, args) {
    await hre.run("verify:verify", {
        address: fundMeAddr,
        constructorArguments: args,
      });
}


module.exports = {}
```

Interact-fundme.js

```javascript
const { task } = require("hardhat/config")

task("interact-fundme", "interact with fundme contract")
		//	增加合约地址的入参
    .addParam("addr", "fundme contract address")
    .setAction(async(taskArgs, hre) => {
  			//初始化合约工厂
        const fundMeFactory = await ethers.getContractFactory("FundMe")
        //这里用attach
        const fundMe = fundMeFactory.attach(taskArgs.addr)

        // 以下是和deployFundMe.js一样的具体合约交互代码
})

module.exports = {}
```

Index.js

```javascript
exports.deployConract = require("./deploy-fundme")
exports.interactContract = require("./interact-fundme")
```

b.在hardhat.config.js中添加如下代码

```javascript
require("./tasks")
```

c.这时在命令行中输入npx hardhat help就可以看到新增的task了

![image-20250625221219916](/Users/mac/Documents/个人/学习/WEB3/Web3_tutorial/screenshot/image-20250625221219916.png)

d.在命令行中就可以对项目分任务执行了

```cmd
mac@MacBook-Pro-3 Web3_tutorial % npx hardhat deploy-fundme --network sepolia
```

```cmd
mac@MacBook-Pro-3 Web3_tutorial % npx hardhat interact-fundme --addr 0x219755235129d42c8D7498e0D6086781111B2b65 --network sepolia
```



## 5.Hardhat 开发框架 ： 合约测试

