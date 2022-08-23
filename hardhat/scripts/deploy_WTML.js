const hre = require("hardhat");

async function main() {

  // 去找WorldTripMulti這個token的合約
  const WorldTripML = await hre.ethers.getContractFactory("WTMultiLocation"); 
  // deploy
  const worldtripml = await WorldTripML.deploy();
  await worldtripml.deployed();

  console.log("WorldTripMulti address:", worldtripml.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
