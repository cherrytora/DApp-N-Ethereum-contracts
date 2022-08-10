const hre = require("hardhat");

async function main() {

  // 去找PokenTest這個token的合約
  const Poken = await hre.ethers.getContractFactory("PokenTest"); 
  // deploy
  const poekn = await Poken.deploy();
  await poekn.deployed();

  console.log("Poken address:", poekn.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
