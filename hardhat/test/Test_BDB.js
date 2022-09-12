const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("WorldTripTest", function() {
  it("Should return the new greeting once it's change", async function(){
    const _name = "BlindBox";
    const _symbol = "BDB";
    const _initBaseURI = "https://raw.githubusercontent.com/cherrytora/DApp-tutorial/main/blindBox/";
    const _initNotRevealedUri = "https://ipfs.io/ipfs/QmV8FTC94m9gpWzWPBETg8Fe614CjwPyUmx7txwfr6M3Xb?filename=blindBox.json";
    const BDB = await ethers.getContractFactory("Blindbox");
    const bdb = await BDB.deploy(_name, _symbol, _initBaseURI, _initNotRevealedUri);
    await bdb.deployed();
  });
});





