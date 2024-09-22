// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract TaskChainToken is ERC20, Ownable {

    error TotalSupplyAlreadyMinted();

    uint256 private constant TOTAL_SUPPLY = 100000000 * 10 ** 18; // 100 million tokens
    uint256 private constant AVAILABLE_SUPPLY = TOTAL_SUPPLY * 20 / 100; // 20% available for use

    constructor() 
        ERC20("TaskChainToken", "TCHN") 
        Ownable(msg.sender)
    {
        _mint(msg.sender, AVAILABLE_SUPPLY); // Mint 20% to the owner
    }

    function allocateVestedTokens(address vestingContract) external onlyOwner {
        if (totalSupply() == TOTAL_SUPPLY) {
            revert TotalSupplyAlreadyMinted(); 
        }
        _mint(vestingContract, TOTAL_SUPPLY - AVAILABLE_SUPPLY); // Mint 80% to the vesting contract
    }

    // View functions to access private variables
    function getTotalSupply() external pure returns (uint256) {
        return TOTAL_SUPPLY;
    }

    function getAvailableSupply() external pure returns (uint256) {
        return AVAILABLE_SUPPLY;
    }
}
