const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PokenTest", function() {
  it("Should return the new greeting once it's change", async function(){
    const Poken = await ethers.getContractFactory("PokenTest");
    const poken = await Poken.deploy();
    await poken.deployed();

  });
});

