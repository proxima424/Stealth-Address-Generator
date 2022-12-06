# Stealth-Address-Generator
Library written in solidity to quickly spin up stealth-addresses for secured transmissions between 2 parties.

### Roadmap
- [ ] Write the CREATE2 function with the focus on visibility and zero constructor args.
- [ ] Write the CREATE2 function with the focus on visibility and two constructor args.
- [ ] Write a modified Ownable.sol to provide admin access to address B, not to the msg.sender(address A)
- [ ] Write a modified Ownable.sol to provide shared access to two addresses ( A and B )
- [ ] Write the bytecode loader function
- [ ] Write a template for airdropping NFTs ( ownership to the other address )
- [ ] Write a template for airdropping NFTs ( shared ownership between A and B. Multisignature transfer )
- [ ] Write a template for airdropping NFTs ( )

Example Use Cases given Address A and Address B:

1) A and B wants to do a certain multi step transaction together and
   they don't would like these  things :
   - Don't have the ledger show frequent transactiveness of A and B
   - Minimize interaction/linkage between A and B
   - Want a trusted intermediary code to achieve common goal

   Either one of them spins up a Stealth Address