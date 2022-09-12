# Create a NFT_REVEAL contract

- 批次發行盲盒抽抽看！
- 盲盒分成兩個部分
    1. 第一個部分是先去讀懂參考資料2.中大神寫好的合約，看看基礎的盲盒需要那些功能，看懂了之後部署玩玩看
    2. 第二個部分是從合約裡面去改成盲盒中5種圖案機率抽抽看！

參考資料：
1. [PecuLab Youtube Video](https://youtu.be/3hMidO1TNT8)
2. [solidity_smart_contracts](https://github.com/HashLips/solidity_smart_contracts/blob/main/contracts/NFT/NFT_REVEAL.sol)
3. [ERC721Enumerable](https://docs.openzeppelin.com/contracts/4.x/api/token/erc721#ERC721Enumerable)

## 盲盒Deploy

1. 合約直接從[solidity_smart_contracts](https://github.com/HashLips/solidity_smart_contracts/blob/main/contracts/NFT/NFT_REVEAL.sol)copy來的，

verify => 要連參數都寫進去

在deploy的時候寫了4個參數，所以在驗證的時候也要把參數寫進去
> const _name \
> const _symbol \
> const _initBaseURI \
> const _initNotRevealedUri 


```
npx hardhat verify --contract contracts/Blindbox.sol:Blindbox --network rinkeby 0xF5760797c6170f8f90d113b254c89D720BbfB7F8 "BlindBox" "BDB" "https://raw.githubusercontent.com/cherrytora/DApp-tutorial/main/blindBox/" "https://ipfs.io/ipfs/QmV8FTC94m9gpWzWPBETg8Fe614CjwPyUmx7txwfr6M3Xb?filename=blindBox.json"
```

接下來要挑戰機率抽盲盒怎麼寫！






