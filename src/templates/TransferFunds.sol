// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib/ECDSA.sol";
import {IERC20} from "../lib/IERC20.sol";

contract TransferFunds {
    using ECDSA for *;

    bytes32 private constant _MALLEABILITY_THRESHOLD =
        0x7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a0;

    function recover(bytes32 hash, bytes calldata signature)
        internal
        view
        returns (address result)
    {
        /// @solidity memory-safe-assembly
        assembly {
            if eq(signature.length, 65) {
                // Copy the free memory pointer so that we can restore it later.
                let m := mload(0x40)
                // Directly copy `r` and `s` from the calldata.
                calldatacopy(0x40, signature.offset, 0x40)

                // If `s` in lower half order, such that the signature is not malleable.
                if iszero(gt(mload(0x60), _MALLEABILITY_THRESHOLD)) {
                    mstore(0x00, hash)
                    // Compute `v` and store it in the scratch space.
                    mstore(
                        0x20, byte(0, calldataload(add(signature.offset, 0x40)))
                    )
                    pop(
                        staticcall(
                            gas(), // Amount of gas left for the transaction.
                            0x01, // Address of `ecrecover`.
                            0x00, // Start of input.
                            0x80, // Size of input.
                            0x40, // Start of output.
                            0x20 // Size of output.
                        )
                    )
                    // Restore the zero slot.
                    mstore(0x60, 0)
                    // `returndatasize()` will be `0x20` upon success, and `0x00` otherwise.
                    result := mload(sub(0x60, returndatasize()))
                }
                // Restore the free memory pointer.
                mstore(0x40, m)
            }
        }
    }

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

    function withdraw(address _tokenAddress, uint256 amount, bytes32 _signature)
        public
        returns (bool success)
    {
        require(amount <= contractTokenBalance(_tokenAddress), "INVALID_AMOUNT");
        address
        IERC20(_tokenAddress).transfer(msg.sender, amount);
    }
}
