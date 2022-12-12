// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {TransferFundsERC20} from "./templates/TransferFundsERC20.sol";
import {TransferFundsERC721} from "./templates/TransferFundsERC721.sol";

contract StealthAddressV1 {
    /*       S-T-O-R-A-G-E V-A-R-I-A-B-L-E-S       */

    mapping(address => uint256) nonceCount;

    /// @notice Address A will deploy a new smart contract
    /// @notice which contains bytecode of TransferFunds
    /// @param _addressB Hash of this address is stored at the new contract

    function deployStealthV1ERC20(
        address _addressB,
        string memory _messageToSignETH,
        uint256 _salt
    )
        external
        returns (address)
    {
        require(_addressB != address(0), "ZERO_ADDRESS");
        bytes memory creationCode = type(TransferFundsERC20).creationCode;
        bytes memory initCode = abi.encodePacked(
            creationCode,
            abi.encode(keccak256(abi.encode(_addressB)), _messageToSignETH)
        );
        address deployedContract;
        assembly {
            deployedContract :=
                create2(0, add(initCode, 0x20), mload(initCode), _salt)
            if iszero(extcodesize(deployedContract)) { revert(0, 0) }
        }
        unchecked {
            nonceCount[msg.sender]++;
        }
        return address(deployedContract);
    }

    function deployStealthV1ERC721(
        address _addressB,
        string memory _messageToSignETH,
        uint256 _salt
    )
        external
        returns (address)
    {
        require(_addressB != address(0), "ZERO_ADDRESS");
        bytes memory creationCode = type(TransferFundsERC721).creationCode;
        bytes memory initCode = abi.encodePacked(
            creationCode,
            abi.encode(keccak256(abi.encode(_addressB)), _messageToSignETH)
        );
        address deployedContract;
        assembly {
            deployedContract :=
                create2(0, add(initCode, 0x20), mload(initCode), _salt)
            if iszero(extcodesize(deployedContract)) { revert(0, 0) }
        }
        unchecked {
            nonceCount[msg.sender]++;
        }
        return address(deployedContract);
    }
}
