// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib/ECDSA.sol";
import {IERC20} from "../lib/IERC20.sol";

contract TransferFundsERC20 {
    using ECDSA for *;

    bytes32 private hashOfAddressB;
    string public messageToSign;

    constructor(bytes32 _hashOfAddressB, string memory _messageToSign) {
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

    function withdraw(
        address _tokenAddress,
        uint256 amount,
        bytes32 _Ethhash,
        bytes memory _signature
    )
        public
        returns (bool success)
    {
        require(amount <= contractTokenBalance(_tokenAddress), "INVALID_AMOUNT");
        require(
            keccak256(abi.encodePacked(ECDSA.recover(_Ethhash, _signature)))
                == hashOfAddressB,
            "INVALID_SIGNATURE"
        );
        IERC20(_tokenAddress).transfer(msg.sender, amount);
        return true;
    }
    
    receive() external payable {}
}
