# Add functions to the NFT contract
# 一張合約發出有不同的照片和屬性（讓一張合約裡面有不同照片的選項）

## 還沒整理好....

參考資料：
1. [PecuLab共學Youtube](https://youtu.be/rSJwzWvAivI)
2. [PecuLab Github](https://github.com/pecu/PecuLab4SEP)

* `npx hardhat clean`會把artifacts(compile後自動產生的)清除

# Steps
......努力進行中

`npx hardhat run scripts/deploy_WTML.js --network rinkeby`
`import WTMLnft from "../contract/WTMultiLocation.json";`
複製json檔
```javascript
async _initializeEthers() {
    // We first initialize ethers by creating a provider using window.ethereum
    this._provider = new ethers.providers.Web3Provider(window.ethereum);

    // Then, we initialize the contract using that provider and the token's
    // artifact. You can do this same thing with your contracts.
    this._token = new ethers.Contract(
      contract_address.PokenTest,
      PokenCoin.abi,
      this._provider.getSigner(0)
    );
    //  initialize the NFT artifact
    this._nft = new ethers.Contract(
      contract_address.WorldTrip,
      WTnft.abi,
      this._provider.getSigner(0)
    );
    // initialize  WTMultiLocation artifact
    this._nft = new ethers.Contract(
      contract_address.WorldTripMulti,
      WTMLnft.abi,
      this._provider.getSigner(0)
    );
```

```javascript
async _minWTML(to, tokenURI){
    try {      
      this._dismissTransactionError();
      const tx = await this._WTML.mint(to, tokenURI);     
      const receipt = await tx.wait();
      if (receipt.status === 0) {
        throw new Error("Mint WTML failed");
      }
    } catch (error) {
      if (error.code === ERROR_CODE_TX_REJECTED_BY_USER) {
        return;
      }
  
      console.error(error);
      this.setState({ transactionError: error });
    } finally {
      this.setState({ txBeingSent: undefined });
    }
  }
```

Back to [README](README.md)