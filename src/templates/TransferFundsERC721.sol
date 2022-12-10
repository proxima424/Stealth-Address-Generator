// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib/ECDSA.sol";
import {IERC20} from "../lib/IERC721.sol";

contract TransferFundsERC721 {
    using ECDSA for *;

    bytes32 private hashOfAddressB;
    string public messageToSign;

    constructor(bytes32 _hashOfAddressB, string memory _messageToSign) {
        _hashOfAddressB = hashOfAddressB;
        messageToSign = _messageToSign;
    }

    function contractTokenBalance(address _tokenId)
        public
        view
        returns (uint256)
    {
        require(_tokenAddress != address(0), "INVALID_ADDRESS");
        return IERC721(_tokenId).balanceOf(address(this));
    }

    function withdraw(
        address _tokenId,
        bytes32 _Ethhash,
        bytes memory _signature
    )
        public
        returns (bool success)
    {
        require(ownerOf(_tokenId)==address(this),"this contract doesn't have the token");
        require(
            keccak256(abi.encodePacked(ECDSA.recover(_Ethhash, _signature)))
                == hashOfAddressB,
            "INVALID_SIGNATURE"
        );
        safeTransferFrom(address(this), msg.sender, _tokenId);
        return true;
    }
    
    receive() external payable {}
}