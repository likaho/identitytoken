const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('IdentityToken', () => {
  let IdentityToken;
  let identityToken: any;
  let owner: { address: any; };
  let addr1: any;
  let addr2;
  let addrs;

  beforeEach(async () => {
    // Get the accounts from Hardhat
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // Deploy the IdentityToken contract
    IdentityToken = await ethers.getContractFactory('IdentityToken');
    identityToken = await IdentityToken.deploy();
    await identityToken.deployed();
  });

  it('Should mint a new token with correct data', async () => {
    const name = 'Joe';
    const tokenId = 0;
    const ipfsHash = 'QmXMsuhZZfKjbjPLJGc59h7NTbCxRhjKtbwBBJyTk38Efa';

    // Call the mint function
    await identityToken.mint(name, ipfsHash);

    // Check the owner of the token
    expect(await identityToken.ownerOf(tokenId)).to.equal(owner.address);

    // Check the IPFS hash associated with the token
    expect(await identityToken.getDataCID(tokenId)).to.equal(ipfsHash);
  });


  // it('Should not allow minting by non-owner', async () => {
  //   const name = 'Joe';
  //   const tokenId = 0;
  //   const ipfsHash = 'QmXMsuhZZfKjbjPLJGc59h7NTbCxRhjKtbwBBJyTk38Efa';

  //   // Call the mint function from a non-owner account
  //   await expect(identityToken.connect(addr1).mint(name, ipfsHash))
  //     .to.be.revertedWith('Caller is not the owner');
  // });

  // Add more test cases as needed to cover other functions and scenarios
});
