# Stealth-Address-Generator
Library written in solidity to quickly spin up stealth-addresses for secured transmissions between 2 parties.
StealthAddressV1 :: Generating Addresses using CREATE2 and enabling anonymity through verifying signatures [ `On-going` ]
StealthAddressV2 :: Generating Addresses using a Shared Secret Key [ `YET TO BE DONE` ]


## Stealth-Address-V1

1) `TransferFundsERC20.sol` </br>
(QuiteBasicButAGoodStartStill) </br>
(GoalOfThisContractCanBeAchievedByJustSendingTheAmountToAnAddressControlledByB) </br>

Address A deploys a Contract C preloading it with `hashOfAddressB` and `messageToSign` </br>
Address A then sends some ERC20 assets to this `Contract C` </br>
Address B accesses the `public` variable `messageToSign` </br>
Address B then generates an `EthereumSignedMessage` and calls `withdraw` function of Contract C. </br>
This function `recovers` address from the signature, `hashes` it and checks it against the variable `hashOfAddressB` </br>
If this returns true, it then `transfers` the required amount. </br>




## Goal

- Hide `frequent transactiveness` of A and B
- Minimize `interaction/linkage` between A and B
- Want a `trusted intermediary code` between two addresses to achieve common goal



### Roadmap
- [X] Write the CREATE2 function with the focus on visibility and zero constructor args.
- [X] Write the CREATE2 function with the focus on visibility and two constructor args.
- [X] Write a modified Ownable.sol to provide admin access to address B, not to the msg.sender(address A)
- [X] Write the bytecode loader function
- [X] Write a template for withdrawing funds [TransferFunds.sol]
- [ ] Implement and Test Transferring Funds ERC20 through StealthAddressV1
- [ ] Implement Transferring Funds ERC721 through StealthAddressV1
- [ ] Write a template for airdropping NFTs ( ownership to the other address )
- [ ] Write a template for airdropping NFTs ( shared ownership between A and B. Multisignature transfer )
- [ ] Implement StealthAddressV2 aka deploying/sending funds to address calculated through EllipticCurveOperations/SharedSecretKey
- [ ] Implement Transferring Funds ERC20 through StealthAddressV2
- [ ] Implement Transferring Funds ERC721 through StealthAddressV2

