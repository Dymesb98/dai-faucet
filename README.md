[![#built_with_Truffle](https://img.shields.io/badge/built%20with-Truffle-blueviolet?style=plastic&logo=Ethereum)](https://www.trufflesuite.com/)

# Dai Faucet
> Dai in Smart Contracts's Tutorial from the [developerguides](https://github.com/makerdao/developerguides/blob/master/dai/dai-in-smart-contracts/README.md) by MakerDao

Dai is the first decentralized stablecoin built on Ethereum by MakerDao.  
The Dai token is based on the [DS-Token](https://dapp.tools/dappsys/ds-token.html) implementation which follow the ERC-20 token standard with minor additions that makes it fit nicely into the Maker system.  
The Dai Stablecoin System involves a series of smart contracts that allows anyone to issue Dai by locking collateral (other valuable crypto assets) into the system.

## Blocks of Code that forms the DaiFaucet contract

### [DaiToken](./contracts/DaiToken.sol)
> Dai Token Interface

To enable our faucet contract to recognize and interact with the Dai token contract we need to write an interface that will map the Dai token functions that we'll use.  
In this case that means the **transfer()** and **balanceOf** functions, since we will need our contract to transfer Dai to whomever requests it and also to check the balanceOf its Dai holdings to know if it can transfer in the first place.  
We will need to instantiate this interface later in the codebase.

## [Owned](./contracts/Owned.sol)
> Contract Ownership

The **Owned** contract sets up the contract creator as the one in control, it sets the **DaiToken daitoken** variable and the **owner** variable.  
It creates the **onlyOwner** modifier function to adds restrictions to who can call the other functions in our faucet contract.  
When deployed on the Korovan network, the constructor function will set the **owner** variable to the address of the calling Ethereum account, and set the **daitoken** variable to the address of the Dai token contract on the Kovan network, which is [0x4f96fe3b7a6cf9725f59d353f723c1bdb64ca6aa](https://kovan.etherscan.io/token/0x4f96fe3b7a6cf9725f59d353f723c1bdb64ca6aa).  
Now the **DaiToken** interface will link the Dai token address on the kovan network. So when we call the **transfer** or **balanceOf** functions, they will call the functions of the Dai token contract.

## [Mortal](./contracts/Mortal.sol)
> Kill Switch


