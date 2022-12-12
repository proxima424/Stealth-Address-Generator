# Stealth-Address-Generator </br>
Library written in solidity to quickly spin up stealth-addresses for secured transmissions between 2 parties.
StealthAddressV1 :: Generating Addresses using CREATE2 and enabling anonymity through verifying signatures     [`On-going` ]</br>
StealthAddressV2 :: Generating Addresses using a Shared Secret Key [ `YET TO BE DONE` ]</br>



## Goal </br>

- Hide `frequent transactiveness` of A and B </br>
- Minimize `interaction/linkage` between A and B </br>
- Want a `trusted intermediary code` between two addresses to achieve common goal </br>


## Stealth-Address-V1 (Write All contracts then integrate using wagmi)

1) `TransferFundsERC20.sol` and `TransferFundsERC721.sol` </br>
(QuiteBasicButAGoodStartStill) </br>
(GoalOfThisContractCanBeAchievedByJustSendingTheAmountToAnAddressControlledByB) </br>

Address A deploys a Contract C preloading it with `hashOfAddressB` and `messageToSign` </br>
Address A then sends some ERC20 assets to this `Contract C` </br>
Address B accesses the `public` variable `messageToSign` </br>
Address B then generates an `EthereumSignedMessage` and calls `withdraw` function of Contract C. </br>
This function `recovers` address from the signature, `hashes` it and checks it against the variable `hashOfAddressB` </br>
If this returns true, it then `transfers` the required amount. </br>





### Roadmap

- [ ] Write testssssssssssss
- [X] Write the CREATE2 function with the focus on visibility and zero constructor args.
- [X] Write the CREATE2 function with the focus on visibility and two constructor args.
- [X] Write a modified Ownable.sol to provide admin access to address B, not to the msg.sender(address A)
- [X] Write the bytecode loader function
- [X] Write a template for withdrawing funds [TransferFunds.sol]
- [X] Write a template for airdropping NFTs ( ownership to the other address )
- [ ] Write a template for airdropping NFTs ( shared ownership between A and B. Multisignature transfer )
- [ ] Implement StealthAddressV2 aka deploying/sending funds to address calculated through EllipticCurveOperations/SharedSecretKey
- [ ] Implement Transferring Funds ERC20 through StealthAddressV2
- [ ] Implement Transferring Funds ERC721 through StealthAddressV2

