const hre = require("hardhat");

async function main() {

  // 去找PokenTest這個token的合約
  const WorldTrip = await hre.ethers.getContractFactory("WorldTrip"); 
  // deploy
  const worldtrip = await WorldTrip.deploy();
  await worldtrip.deployed();

  console.log("WorldTrip address:", worldtrip.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
