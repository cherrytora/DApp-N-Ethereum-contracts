const hre = require("hardhat");

// You might need the previously deployed yourToken:
async function main() {

  // 去找Vendor這個合約
  const Vendor = await hre.ethers.getContractFactory("Vendor");
  // deploy Vendor
  const vendor = await Vendor.deploy();
  await vendor.deployed();

  console.log("vendor deployed to:", vendor.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});