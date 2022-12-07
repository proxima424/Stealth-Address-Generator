// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ECDSA} from "../lib//ECDSA.sol";
import {Ownable} from "../Ownable_CUSTOM1.sol";


contract TransferFunds is Ownable {

        address private AddressB;
        string public messageToSign;

        constructor(address _AddressB, string memory _messageToSign) Ownable(_AddressB){
            AddressB = _AddressB;
        }

        modifier onlyAddressB(){
            require()
        }









}

