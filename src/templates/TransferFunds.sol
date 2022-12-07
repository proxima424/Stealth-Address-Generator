// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib/ECDSA.sol";
import {IERC20} from "../lib/IERC20.sol";

contract TransferFunds {
    using ECDSA for *;

    address private hashOfAddressB;
    string public messageToSign;

    constructor(bytes32 memory _hashOfAddressB, string memory _messageToSign) {
        _hashOfAddressB = hashOfAddressB;
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
        require(abi.encodePacked(recover()) == hashOfAddressB, "INVALID_USER");
        IERC20(_tokenAddress).transfer(msg.sender, amount);
    }
}
