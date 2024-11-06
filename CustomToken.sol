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
}

