// import ethers.js
// create main function
// execute main function

//引入这个包
const { config } = require("dotenv")
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

    console.log("chaindId : " + hre.network.config.chainId)
    console.log("ETHERSCAN_API_KEY : " + process.env.ETHERSCAN_API_KEY)
    if ( hre.network.config.chainId == 11155111 && process.env.ETHERSCAN_API_KEY){
        
        console.log("waiting for 5 blocks to confirm transaction")
        await fundMe.deploymentTransaction().wait(5)
        await verifyFundMe(fundMe.target, [300])

    }else {
        console.log("verification not required")
    }
    console.log("The contract has been verified successfully")

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

    //check mapping
    const firstAccountBalanceInFundMe = await fundMe.fundersToAmount(firstAccount.address)
    const secondAccountBalanceInFundMe = await fundMe.fundersToAmount(secondAccount.address)
    console.log(`Balance of first account in FundMe is ${firstAccountBalanceInFundMe}`)
    console.log(`Balance of second account in FundMe is ${secondAccountBalanceInFundMe}`)




}

// verify函数
async function verifyFundMe(contractAddress,args){
    hre.run("verify:verify", {
        address: contractAddress,
        constructorArguments: args
    })
}

// 捕获main函数的错误
main().then().catch((error) => {
    console.error(error)
    process.exit(0)
})