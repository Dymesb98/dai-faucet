[![#ubuntu 18.04](https://img.shields.io/badge/ubuntu-v18.04-orange?style=plastic)](https://ubuntu.com/download/desktop)
[![#npm 12.14](https://img.shields.io/badge/npm-v12.14-blue?style=plastic)](https://github.com/nvm-sh/nvm#installation-and-update)
[![#built_with_Truffle](https://img.shields.io/badge/built%20with-Truffle-blueviolet?style=plastic)](https://www.trufflesuite.com/)
[![#solc 0.5.9](https://img.shields.io/badge/solc-v^0.5.9-brown?style=plastic)](https://github.com/ethereum/solidity/releases?after=v0.5.11)
[![#testnet kovan](https://img.shields.io/badge/testnet-Kovan-purple?style=plastic&logo=Ethereum)](https://kovan.etherscan.io/address/0x527903d7938fba0b2a88b55244b0eafb28047ff6)
# Dai Faucet

> Dai in Smart Contracts's Tutorial from the [developerguides](https://github.com/makerdao/developerguides/blob/master/dai/dai-in-smart-contracts/README.md) by [MakerDAO](https://makerdao.com/en/) using Truffle & Remix.


Dai is the first decentralized stablecoin built on Ethereum by MakerDAO.  
The Dai token is based on the [DS-Token](https://dapp.tools/dappsys/ds-token.html) implementation which follow the ERC-20 token standard with minor additions that makes it fit nicely into the Maker system.  
The Dai Stablecoin System involves a series of smart contracts that allows anyone to issue Dai by locking collateral (other valuable crypto assets) into the system.

## Sections
* [Building Blocks](#building-blocks-of-the-daifaucet-contract)
* [Setup](#setup)
* [Deploy DaiFaucet](#deploy-on-kovan-testnet)
* [Use Faucet](#use-faucet)

## Building Blocks of the DaiFaucet contract

### [DaiToken](./contracts/Owned.sol)
> Dai Token Interface

To enable our faucet contract to recognize and interact with the Dai token contract we need to write an interface that will map the Dai token functions that we'll use.  
In this case that means the **transfer()** and **balanceOf** functions, since we will need our contract to transfer Dai to whomever requests it and also to check the balanceOf its Dai holdings to know if it can transfer in the first place.  
We will need to instantiate this interface later in the codebase.

### [Owned](./contracts/Owned.sol)
> Contract Ownership

The **Owned** contract sets up the contract creator as the one in control, it sets the **DaiToken daitoken** variable and the **owner** variable.  
It creates the **onlyOwner** modifier function to adds restrictions to who can call the other functions in our faucet contract.  
When deployed on the Kovan network, the constructor function will set the **owner** variable to the address of the calling Ethereum account, and set the **daitoken** variable to the address of the Dai token contract on the Kovan network, which is [0x4f96fe3b7a6cf9725f59d353f723c1bdb64ca6aa](https://kovan.etherscan.io/token/0x4f96fe3b7a6cf9725f59d353f723c1bdb64ca6aa).  
Now the **DaiToken** interface will link the Dai token address on the kovan network. So when we call the **transfer** or **balanceOf** functions, they will call the functions of the Dai token contract.

### [Mortal](./contracts/Mortal.sol)
> Kill Switch

The **Mortal** contract inherit the **Owned** contract and give our contract a kill switch that will terminate it and return any funds back to the owner.  
The **destroy** function can only be called by the owner, hence the **onlyOwner** modifier.  
Here we use the **daitoken** interface, transfering any remaining Dai funds of the faucet contract to the owner.  

### [DaiFaucet](./contracts/DaiFaucet.sol)
> Dai Faucet

The **DaiFaucet** contract inherits the **Mortal** contract, which in turn inherits the **Owned** contract, which finally inherits the **DaiToken** interface. This way, we have modularised our contracts for their specific functions and added our total control over it.  
Inside the contract we have two events that will watch and log every time there is a **Withdrawal** and a **Deposit** to/from this contract.  
We have added the **withdraw** function that will take care to send Dai to anyone who calls this function. As you can see, we have added 2 conditions for the withdrawal: 
* Require that the withdraw_amount is less or equal to 0.1 Dai;
* Require that we have more Dai in the faucet than the withdraw_amount;  

Only after these conditions are met we can transfer 0.1 Dai to the function caller. And of course, we log this transaction with the Withdrawal event. The way we send Dai to the function caller is by using the above defined DaiToken interface to allow us to make the transfer.  
The fallback function is here to receive any incoming payments our contracts gets and log the Deposit event.  

## Setup

> Clone this GitHub repository.

## Steps to Compile and Deploy
- Global dependencies
    - Truffle & Ganache:
    ```sh
    $ npm install -g truffle ganache-cli
    ```
## Running the project with local test network (ganache-cli)

 - Start ganache-cli with the following command:
   ```sh
   $ ganache-cli
   ```
 - Compile the smart contract using Truffle with the following command:
   ```sh
   $ truffle compile
   ```
 - Deploy the smart contracts using Truffle & Ganache with the following command:
   ```sh
   $ truffle migrate
   ```

## Deploy on Kovan Testnet
 - Get an Ethereum Account on Metamask.
 - On the landing page, click “Get Chrome Extension.”
 - Create a .secret file cointaining the menomic.
 - Get some test ether from a [Kovan's faucet](https://faucet.kovan.network/).
 - Signup [Infura](https://infura.io/).
 - Create new project.
 - Copy the rinkeby URL into truffle-config.js.
 - Uncomment the following lines in truffle-config.js:
   ```
   // const HDWalletProvider = require("@truffle/hdwallet-provider");
   // const infuraKey = '...';
   // const infuraURL = 'https://kovan.infura.io/...';

   // const fs = require('fs');
   // const mnemonic = fs.readFileSync(".secret").toString().trim();
   ```
 - Install Truffle HD Wallet Provider:
   ```sh
   $ npm install @truffle/hdwallet-provider
   ```
 - Deploy the smart contract using Truffle & Infura with the following command:
   ```sh
   $ truffle migrate --network kovan
   ```
   
## Use Faucet

The contract has been deployed on Kovan network using [Infura](https://kovan.etherscan.io/address/0xfbc9b15453e774a700dC2CBDf65F5fa03EE0d77B) and [Remix](https://kovan.etherscan.io/address/0x527903d7938fba0b2a88b55244b0eafb28047ff6).  
Now that we have successfully deployed our smart contract on the Kovan network, we can interact with it.  
The simplest way to interact with the contract is through Etherscan.  
As you are the deployer of this contract, you have the source code.  
This means that you can publish the source code to Etherscan and verify the contract.  
This allows you to interact with the contract on Etherscan with just your MetaMask account. Easy right?

### Verify Contract

To verify your contract and publish your source code, navigate to your contract address on Etherscan and click on the **Verify and Publish** link.  
Select the compiler type to be **Single File** to be used for the Remix all in one file source code.  
sure to select the right compiler version that your contract has been compiled against and then press continue.  
Paste the Solidity code used in [Remix](./remix/DaiFaucet.sol), and then press **Verify and Publish**.  

Congratulations! Your contract is verified, now you can interact with it from [Etherscan](https://kovan.etherscan.io/address/0x527903d7938fba0b2a88b55244b0eafb28047ff6#writeContract) with Metamask.















