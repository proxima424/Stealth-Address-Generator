// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {MockERC20} from "../src/Mocks/MockERC20.sol";
import {TransferFundsERC20} from "../src/templates/TransferFundsERC20.sol";

contract TransferFundsERC20Test is Test{
    MockERC20 token;
    TransferFundsERC20 alpha;
    uint256 internal ownerPrivateKey;
    address internal ownerAdr;

    function setUp() public {
        token = new MockERC20("DNS","DNS",18);
        ownerPrivateKey = 0xA11CE;
        ownerAdr = vm.addr(ownerPrivateKey);
        alpha = new TransferFundsERC20(keccak256(abi.encodePacked(ownerAdr)),"Sign me");
    }

    function testMESSAGETOSIGN() public {
        assertEq(alpha.getMessageToSign(),"Sign me");
    }

    function testHASHOFADDRESSB() public {
        assertEq(alpha.getHashOfAddressB(),keccak256(abi.encodePacked(ownerAdr)));
    }

    function testCONTRACTBALANCE() public {
        token.mint(address(this),1e18);
        token.transfer(address(alpha),1e18);

        assertEq(token.balanceOf(address(this)),0);
        assertEq(token.balanceOf(address(alpha)),1e18);
        assertEq(alpha.contractTokenBalance(address(token)),1e18);
    }



}