// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Deploy a contract from address A and allocate Access Control Mechanism to a different address B
/// @title Unlike Ownable.sol which creates
/// @author <proxima424> <https://github.com/proxima424>
/// @author <prince> <https://github.com/PRINCEPOPOSOS>
/// @notice Core logic copied from <openzeppelin-contracts/Ownable.sol>
/// @dev [ Retreiving msg.sender functions ] from Context.sol embedded in a single contract

/*
This contract will be inherited by the template contract
and will require address of the "to be set" owner as its
constructor argument.
*/

contract Ownable {
    /*       S-T-O-R-A-G-E V-A-R-I-A-B-L-E-S           */
    address private _owner;

    /*               E-V-E-N-T-S                      */
    event OwnershipTransferred(
        address indexed previousOwner, address indexed newOwner
    );

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    ///@dev Initializes the contract setting the constructor arg as owner
    constructor(address receiverr) {
        require(receiverr != address(0), "INVALID_ADDRESS");
        _transferOwnership(receiverr);
    }

    ///@dev Our beloved modifier
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    ///@dev Checks if caller is the owner
    function _checkOwner() internal view virtual {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
    }

    ///@dev Removes access to all onlyOwner fns hence leaving the user without any administrative access
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    ///@dev Transfers ownership to a different address
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "INVALID_ADDRESS");
        _transferOwnership(newOwner);
    }

    /// @dev Transfers ownership of the contract to a new account (`newOwner`).
    /// Internal function without access restriction.
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
