# Create NFT

參考資料：
1. [PecuLab共學Youtube](https://youtu.be/StJ_gqnb-ms)
2. [PecuLab Github](https://github.com/pecu/PecuLab4SEP)
3. [ipfs docs](https://docs.ipfs.tech/)


## 前置作業
### ipfs 介紹
1.什麼是ipfs? 
> ipfs 的全名是 InterPlanetary File System。簡單的說，ipfs會像git一樣，為每個檔案建立一個hash值，不會有兩個檔案有相Hash值的情況，有點像人類的指紋一樣，每個人的指紋都不同，如果要辨識這個人的身份，可以從指紋去辨識。ipfs有點類似這樣在運作，在找尋檔案的時候，是透過hash值去找的，而不是傳統的http位址。ipfs並不是一種區塊鏈技術，但他的宗旨是要和區塊鏈結合協同運作。
詳細的內容可以參考：[IPFS 分散式檔案系統](https://www.samsonhoi.com/689/blockchain-ipfs-intro) 和 [入門淺談：什麼是 IPFS？](https://blockcast.it/2019/10/16/let-me-tell-you-what-is-ipfs/)喔！

2. 有ipfs的概念之後，就可以開始來實作啦！首先要去[ipfs](https://ipfs.tech/)下載desktop版
3. 先把想做成NFT的檔案上傳，這邊要注意，上傳之後這張圖片就會被賦予一個hash值，所以如果上傳後想要再作修改hash值也會改變，相對應的code都需要調整，所以建議確定好再上傳！然後複製URL![](images/ipfs_share.png)
4. 上傳一個json檔，裡面要寫好剛剛傳到ipfs的URL和一些形容這個NFT的屬性，大概像這樣子
```json
{ 
    "image":"ipfs URL",
    "attributes": // trait_type和value都可以自己定義
        [
            {
                "trait_type":"background", 
                "value":"World Trip"
            },
            {
                "trait_type":"location",
                "value":"Uyuni"
            },
            {
                "trait_type":"country",
                "value":"Bolivia"

            },
            {
                "trait_type":"source",
                "value":"Sirius"
            }
            
        ]
}
```

### deploy NFT

部署NFT和token的過程是一樣的
1. 去openzeppelin做一個基礎版的合約，這邊跟token不一樣的是要選擇721，選好後下載放到`hardhat/contracts`
![](images/openzepplin_721.png)
* 這邊要注意，填入合約個URL是json的URL喔！不是照片的URL
2. 建立 test 和deploy檔案，進行compile和test

```
npx hardhat compile
npx hardhat test
``` 
* 如果想要只執行test資料夾裡面的一個檔案，可以這樣下指令
```
npx hardhat test test/Test_WT.js
npx hardhat test <folder>/<file name>.js
```
3. 都沒問題後就可以deploy，拿到address
```
npx hardhat run scripts/deploy_WT.js --network rinkeby
```

### Mint & 加入 DApp
....更新中

Mint.js
dapp.js



 
 

