const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("WorldTripTest", function() {
  it("Should return the new greeting once it's change", async function(){
    const WorldTrip = await ethers.getContractFactory("WorldTrip");
    const worldtrip = await WorldTrip.deploy();
    await worldtrip.deployed();

  });
});

