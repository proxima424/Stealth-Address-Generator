// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {StealthAddressV1} from "../src/StealthAddressV1.sol";
import {TransferFundsERC20} from "../src/templates/TransferFundsERC20.sol";

contract StealthAddressV1Test is Test {
    StealthAddressV1 UFC;

    function setUp() public {
        UFC = new StealthAddressV1();
    }

    function testdeployStealthV1ERC20() public {}
}
