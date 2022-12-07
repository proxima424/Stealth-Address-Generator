// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib/ECDSA.sol";
import {Ownable} from "../Ownable_CUSTOM1.sol";
import {IERC20} from "../lib/IERC20.sol";

contract TransferFunds is Ownable {
    using ECDSA for *;

    address private AddressB;
    string public messageToSign;

    constructor(address _AddressB, string memory _messageToSign)
        Ownable(_AddressB)
    {
        AddressB = _AddressB;
        messageToSign = _messageToSign;
    }

    function contractTokenBalance(address _tokenAddress)
        public
        view
        returns (uint256)
    {
        require(_tokenAddress != address(0), "INVALID_ADDRESS");
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress, uint256 amount)
        public
        returns (bool success)
    {
        require(amount <= contractTokenBalance(_tokenAddress), "INVALID_AMOUNT");
        require(recover() == AddressB, "INVALID_USER");
        IERC20(_tokenAddress).transfer(msg.sender, amount);
    }
}
