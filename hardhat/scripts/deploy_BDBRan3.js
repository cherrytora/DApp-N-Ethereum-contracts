const hre = require("hardhat");

async function main() {
 
  const BDBR = await ethers.getContractFactory("BlindboxRan3");
  
  // 把參數設定在這邊
  const _name = "BlindBox Random V3";
  const _symbol = "BDBR3";
  // 解盲後的URL資料夾
  const _initBaseURI = "https://raw.githubusercontent.com/cherrytora/DApp-tutorial/main/blindBox/";
  // 盲盒的URL
  const _initNotRevealedUri = "https://ipfs.io/ipfs/QmV8FTC94m9gpWzWPBETg8Fe614CjwPyUmx7txwfr6M3Xb?filename=blindBox.json";
  // deploy
  const bdbr = await BDBR.deploy(_name, _symbol, _initBaseURI, _initNotRevealedUri);
  await bdbr.deployed();
  // 印出address
  console.log("bdbr deployed to:", bdbr.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});