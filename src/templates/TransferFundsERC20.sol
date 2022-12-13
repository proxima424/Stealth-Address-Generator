// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib/ECDSA.sol";
import {IERC20} from "../lib/IERC20.sol";

contract TransferFundsERC20 {
    using ECDSA for *;

    bytes32 public hashOfAddressB;
    string public messageToSign;

    constructor(bytes32 _hashOfAddressB, string memory _messageToSign) {
        hashOfAddressB = _hashOfAddressB;
        messageToSign = _messageToSign;
    }

    function getHashOfAddressB() public view returns (bytes32 ) {
        return hashOfAddressB;
    }

    function getMessageToSign() public view returns (string memory) {
        return messageToSign;
    }

    function contractTokenBalance(address _tokenAddress)
        public
        view
        returns (uint256)
    {
        require(_tokenAddress != address(0), "INVALID_ADDRESS");
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function recoverAdrFromSignature (bytes32 _EthHash, bytes memory _signature)
        public
        view
        returns (address)
    {
        return ECDSA.recover(_EthHash, _signature);
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
            keccak256(abi.encodePacked(recoverAdrFromSignature(_Ethhash, _signature)))
                == hashOfAddressB,
            "INVALID_SIGNATURE"
        );
        IERC20(_tokenAddress).transfer(msg.sender, amount);
        return true;
    }
}
