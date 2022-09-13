# Create a NFT_REVEAL contract

- 批次發行盲盒抽抽看！
- 盲盒分成兩個部分
    1. 第一個部分是先去讀懂參考資料2.中大神寫好的合約，看看基礎的盲盒需要那些功能，看懂了之後部署玩玩看
    2. 第二個部分是從合約裡面去改成盲盒中5種圖案隨機抽抽看！

參考資料：
1. [PecuLab Youtube Video](https://youtu.be/3hMidO1TNT8)
2. [solidity_smart_contracts](https://github.com/HashLips/solidity_smart_contracts/blob/main/contracts/NFT/NFT_REVEAL.sol)
3. [ERC721Enumerable](https://docs.openzeppelin.com/contracts/4.x/api/token/erc721#ERC721Enumerable)

## 盲盒合約閱讀及Deploy

### STEP 1. 合約
1. 合約直接從[solidity_smart_contracts](https://github.com/HashLips/solidity_smart_contracts/blob/main/contracts/NFT/NFT_REVEAL.sol)複製來的，詳細的註解直接看[合約](hardhat/contracts/Blindbox.sol)
2. 在reveal的地方加了一個判斷式，讓他可以是點了之後解盲，再點一次又可以變成盲盒，原先的設定是點了之後就不能再變回盲盒，但是每點一次都會被收gas，要注意測試幣夠不夠～
```javascript
function reveal() public onlyOwner {
      if (revealed==true) {
        revealed = false;
      }
      else
      {
        revealed = true;
      }   
  }
```

### STEP 2. deploy
1. 這個合約裡有4個留給時候才傳進去的參數，分別是_name、 _symbol、 _initBaseURI和_initNotRevealedUri，所以部署的檔案就不能完全抄以前的，要增加一些東西，，這些參數如果直接寫在合約裡也可以。
```javascript
const hre = require("hardhat");

async function main() {
  // 去找出合約
  const BDB = await ethers.getContractFactory("Blindbox");
  // 把參數設定在這邊
  const _name = <<名稱>>;
  const _symbol = <<縮寫>>;
  // 解盲後的URL資料夾
  const _initBaseURI = <<URL>>;
  // 盲盒的URL
  const _initNotRevealedUri = <<URL>>;
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
```
2. 寫好之後就可以來deploy了！
```
npx hardhat clean
npx hardhat compile
npx hardhat run scripts/deploy_BDB.js --network rinkeby
```

### STEP 3. Verify
又會再度Error啦！coding就是在不斷的error中度過，哈哈哈！
![](images/Blind_ver_error.png)
這個錯誤是說我們在deploy的時候寫了下面4個參數，所以在驗證的時候也要把參數寫進去，然後我為了避免還有其他的問題，所以把要驗證的合約也一起加到指令裡面，verify的指令就變得很長ＸＤ
> const _name \
> const _symbol \
> const _initBaseURI \
> const _initNotRevealedUri 

```
npx hardhat verify --contract contracts/Blindbox.sol:Blindbox --network rinkeby 0xF5760797c6170f8f90d113b254c89D720BbfB7F8 "BlindBox" "BDB" "https://raw.githubusercontent.com/cherrytora/DApp-tutorial/main/blindBox/" "https://ipfs.io/ipfs/QmV8FTC94m9gpWzWPBETg8Fe614CjwPyUmx7txwfr6M3Xb?filename=blindBox.json"
```
這樣就成功啦！每次看到成功都覺得好～感動！
![](images/blind_ver_succ.png)

### STEP 4. opensea看看在部署合約的時候順便發給自己的盲盒
1. 首先是盲盒的樣子
![](images/Blindcover_opensea.png)
![](images/Blind_opensea.png)

2. 解盲的樣子（解盲到[Etherscan](https://rinkeby.etherscan.io/address/0xf5760797c6170f8f90d113b254c89d720bbfb7f8#readContract)上連結錢包，點reveal做喔！）
![](images/Blindcover_unblind.png)
![](images/Blind_unblind.png)


## 隨機盲盒抽抽看

接下來要挑戰隨機抽盲盒怎麼寫！






