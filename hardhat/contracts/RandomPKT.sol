pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import './PokenTest.sol';

contract RandomPKT2 is Ownable {

 // 把PKT接回來，當作myToken這個變數的名稱
  PokenTest myToken;
  uint private _rand = 5;

  // 加上一個random function
  function _getRandom(uint256 _start, uint256 _end) private returns(uint256) {
      if(_start == _end){
          return _start;
      }
      uint256 _length = _end - _start;
      uint256 random = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, _rand)));
      random = random % _length + _start;
      _rand++;
      return random;
  }

  

  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);

  constructor() {
    myToken = PokenTest(0x73715Ec8e26FF669F246753699e618871E430f52);
  }

  function buyTokens() payable public {
    // 確定購買者有>0個ether，避免有人沒錢進行交易，導致不必要的gas費用
    // 這邊也可以設定看一個token要賣多少ether，去確定購買者的帳戶至少可以買一個token
    require(msg.value > 0, "Not enought ether");
    
    // 一個Ether可以買幾個我們發的token
    uint256 tokensPerEth = _getRandom(500,1000);
    // 這邊是把要買幾個token換算成需要多少ether
    uint256 amountOfTokens = msg.value * tokensPerEth;

    // 確定購買者有足夠的存款
    uint256 tokenBalance = myToken.balanceOf(address(this));
    require(tokenBalance > amountOfTokens, "Not enought tokens");
    
    // 上面都確定完之後才進行transfer
    bool sent =  myToken.transfer(msg.sender, amountOfTokens);
    require(sent, "Failed to transfer token to the buyer");

    // 透過emit啟動BuyTokens這個event
    // emit和上面的event是一起的，有event就有emit，不要忘記囉！
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // onlyOwner 只有合約的擁有者可以使用這個function
  // withdraw 這個是在做提錢的動作，把賣token賺到的錢轉回合約擁走者的錢包裡
  function withdraw() public onlyOwner {

    uint256 balance = address(this).balance;
    require(balance > 0, "No ether to withdraw");
    
    (bool sent, ) = msg.sender.call{value: balance}("");
    require(sent, "Failed to withdraw balance");
  }
}