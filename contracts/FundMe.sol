//SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

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
    uint256 constant MIN_VALUE = 10 * 10 ** 18;//USD

    //设置目标值
    uint256 constant TARGET = 1000 * 10 ** 18;

    //部署时间
    uint256 deploymentTimestamp;

    //锁定时间
    uint256 lockTime;

    address owner;

    bool public getFundSuccess = false;

    address erc20Addr;



    //创建一个收款函数
    function fund() external payable {
        require(convertEth2USD(msg.value) >= MIN_VALUE, "Fund must be at least 1 ETH");
        require(block.timestamp < deploymentTimestamp + lockTime, "Locktime has not passed yet") ;
        fundersToAmount[msg.sender] = msg.value;
    } 

    //
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
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    //将以太币转换为美元计算
    function convertEth2USD(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return ethAmount * ethPrice/(10**8) ;
    }

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

    function reFund() external {
        require(convertEth2USD(address(this).balance) < TARGET ,"Target is not reached");
        require(fundersToAmount[msg.sender] != 0 , "Nothing to reFund");

        bool success;
        (success, ) = payable(msg.sender).call{value : fundersToAmount[msg.sender]}("");
        require(success,"Failed to refund");
        fundersToAmount[msg.sender] = 0;
    }

    modifier windowClosed() {
        require(block.timestamp >= deploymentTimestamp + lockTime, "Locktime has passed") ;
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Not the Owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner{
        owner = newOwner;
    }

    function setFunderToAmount(address funder,uint256 amountToUpdate) external {
        require(msg.sender == erc20Addr,"You don't have this permission to call this function");
        fundersToAmount[funder] = amountToUpdate;

    }

    function setErc20Addr(address _erc20Addr) public onlyOwner{
        // this is called by an authorized owner
        // to upgrade the address of msg.sender to newOwner
        erc20Addr = _erc20Addr;
    }

}

