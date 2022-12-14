const hre = require("hardhat");

async function main() {
 
  const BDB = await ethers.getContractFactory("Blindbox");
  
  // 把參數設定在這邊
  const _name = "BlindBox";
  const _symbol = "BDB";
  // 解盲後的URL資料夾
  const _initBaseURI = "https://raw.githubusercontent.com/cherrytora/DApp-tutorial/main/blindBox/";
  // 盲盒的URL
  const _initNotRevealedUri = "https://ipfs.io/ipfs/QmV8FTC94m9gpWzWPBETg8Fe614CjwPyUmx7txwfr6M3Xb?filename=blindBox.json";
  // deploy
  const bdb = await BDB.deploy(_name, _symbol, _initBaseURI, _initNotRevealedUri);
  await bdb.deployed();
  // 印出address
  console.log("bdb deployed to:", bdb.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});