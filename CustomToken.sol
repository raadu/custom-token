// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract CustomToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        // Set deployer as default admin
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        // Allow deployer to mint tokens
        _grantRole(MINTER_ROLE, msg.sender);

        // Mint initial supply to deployer
        _mint(msg.sender, initialSupply * 10**decimals());
    }

    function mint(address to, uint256 amount) external payable {
        require(hasRole(MINTER_ROLE, msg.sender), "ACCESS DENIED: Caller is not a minter");
        _mint(to, amount * 10**decimals());
    }

    function mintTokensToContract(uint256 amount) external payable {
        // Mint tokens to the contract adress. 
        // Needed to burn token from contract address later during transfers.
        require(hasRole(MINTER_ROLE, msg.sender), "ACCESS DENIED: Caller is not a minter");
        _mint(address(this), amount * 10**decimals());
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        // Burn 1% of the transfer amount from the contract address.
        uint256 burnAmount = amount / 100; // 1% burn
        uint256 buybackAmount = amount / 100; // 1% buyback
        uint256 transferAmount = amount * 10**decimals();
        uint256 totalBurnOrBuyback = burnAmount + buybackAmount;

        // Address where buyback tokens will be sent
        // address buybackWallet = 0xYourBuybackWalletAddress; // Replace with actual buyback wallet address

        // Ensure reserve has enough tokens for burning
        require(balanceOf(address(this)) >= totalBurnOrBuyback, "Reserve has insufficient tokens to burn");

        // Burn from the reserve
        _burn(address(this), burnAmount);

        // Transfer buyback amount to the buyback wallet
        // super.transfer(buybackWallet, buybackAmount);

        // Transfer the full amount to the recipient
        return super.transfer(recipient, transferAmount);
    }

    function getContractBalance() public view returns (uint256) {
        // Get balance of the current contract
        return balanceOf(address(this));
    }
}

