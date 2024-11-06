# Introduction
This is a smart contract to make custom ERC20 token on Ethereum Network. Custom token name, symbol and initial supply value can be given.

# Technologies Used
 - Solidity 
 - Polygon
 - OpenZeppelin Contracts

# How to deploy contract
- Copy the code of CustomContract.sol file to Remix IDE
- Compile the code.
- Go to the deploy window. Select `Injected Provider: Metamask` as environment. 
- To deploy the contract, some gas fee is needed. Go to https://faucet.polygon.technology to get free POL tokens to use as gas fee.
    - Select network: Polygon PoS (Amoy)
    - Token: POL
    - Type your metamask wallet address. 
    - Hit submit to get free tokens
- In Remix IDE, Select CustomToken.sol file as selected Contract
- Input token name, symbol and initial supply amount. 
- Click `transact` button to deploy

The contract will be deployed to Polygon Network's Amoy Testnet.
After deploy, copy the deployed contract's address.
Paste the address in this link to see your token status, transactions and othe info.
https://amoy.polygonscan.com/address/CONTRACT_ADDRESS

