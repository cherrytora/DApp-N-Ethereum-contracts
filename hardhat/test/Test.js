const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("PokenTest", function() {
  it("Should return the new greeting once it's change", async function(){
    const Poken = await ethers.getContractFactory("PokenTest");
    const poken = await Poken.deploy();
    await poken.deployed();

  });
});
