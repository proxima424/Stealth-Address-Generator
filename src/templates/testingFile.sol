// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FactoryAssembly {
    event Deployed(address addr, uint256 salt);

    function getBytecode(bytes32 _hash) public pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_hash));
    }

    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );
        return address(uint160(uint256(hash)));
    }

    function deploy(bytes memory bytecode, uint256 _salt) public payable {
        address addr;
        assembly {
            addr :=
                create2(callvalue(), add(bytecode, 0x20), mload(bytecode), _salt)
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        emit Deployed(addr, _salt);
    }
}

contract TestContract {
    bytes32 private hashOfB;

    constructor(bytes32 _hash) payable {
        hashOfB = _hash;
    }

    modifier isB() {
        require(
            keccak256(abi.encode(msg.sender)) == hashOfB,
            "you are not the right person"
        );
        _;
    }

    function getBalance() public view isB returns (uint256) {
        return address(this).balance;
    }

    function withdraw(uint256 _amount) public isB {
        payable(address(msg.sender)).transfer(_amount * (10 ** 18));
    }

    receive() external payable {}
}
