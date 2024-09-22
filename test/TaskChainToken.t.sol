// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TaskChainToken.sol"; 

contract TokenTest is Test {
    TaskChainToken private token;
    address private owner;
    address private vestingContract;

    function setUp() public {
        owner = address(this); 
        vestingContract = address(0x123); 
        token = new TaskChainToken(); 
    }

    function testInitialBalance() public view {
        
        uint256 balance = token.balanceOf(owner);
        assertEq(balance, 20_000_000 * 10 ** 18, "20% of the total supply"); 
    }

    function testAllocateVestedTokens() public {
 
        token.allocateVestedTokens(address(vestingContract)); 

        uint256 totalSupplyAfterAllocation = token.totalSupply();
        uint256 expectedTotalSupply = token.getTotalSupply();
        
        assertEq(totalSupplyAfterAllocation, expectedTotalSupply, "Total supply should now equal total supply after allocation");
    }

    function testGetTotalSupply() public {
        uint256 totalSupply = token.getTotalSupply();

        assertEq(totalSupply, 100_000_000 * 10**18, "Total supply should be 100 million tokens");
    }

    function testGetAvailableSupply() public {
        uint availableSupply = token.getAvailableSupply();

        assertEq(availableSupply, 20_000_000 * 10**18, "Available supply should be 20 million tokens");
    }

    function testFailOnlyOwnerCanAllocate() public {
       
        address nonOwner = address(0x456);
        vm.startPrank(nonOwner);
        vm.expectRevert("Ownable: caller is not the owner");
        token.allocateVestedTokens(vestingContract);
        vm.stopPrank();
    }
    
    function testFailCannotMintMoreThanTotalSupply() public {
        address randomAddress = address(0x123); 

        vm.expectRevert(TaskChainToken.TotalSupplyAlreadyMinted.selector);
        token.allocateVestedTokens(randomAddress);
    }
}
