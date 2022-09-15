// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BlindboxRan3 is ERC721Enumerable, Ownable {
  using Strings for uint256;

  string public baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 0.05 ether; // 一張多少錢
  uint256 public maxSupply = 100; // 一共發行多少張
  uint256 public maxMintAmount = 5; // 一次可以買幾張
  bool public paused = false; // 是否停賣
  bool public revealed = false; //  是否解盲
  string public notRevealedUri; // 盲盒的URI
  uint private _rand = 3; // 設定隨機種子
  mapping(address => bool) public whitelisted;
  mapping(uint256 => string) private _tokenURIs; // 把他想像成dic

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    string memory _initNotRevealedUri
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
    // 發合約的時候直接就先mint給自己
    mint(msg.sender, 3);
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public
  function mint(address _to, uint256 _mintAmount) public payable {
    uint256 supply = totalSupply();
    require(!paused);
    require(_mintAmount > 0);
    require(_mintAmount <= maxMintAmount);
    require(supply + _mintAmount <= maxSupply);
    
    if (msg.sender != owner()) {
        if(whitelisted[msg.sender] != true) {
          require(msg.value >= cost * _mintAmount);
        }
    }

    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(_to, supply + i);
      _Id_Urls(supply + i);
    }
  }

  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  //  生成偽隨機數列(似乎無法生成真正的隨機數列？)
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

// 這邊是設定每個URL建立一個array，去把不同URI各自收起來
  function _Id_Urls(uint256 tokenId) internal virtual {
      require(
          _exists(tokenId),
          "ERC721Metadata: URI set of nonexistent token"
      );  // Checks if the tokenId exists
      uint256 BDnum = _getRandom(1,6);
      string memory currentBaseURI = _baseURI();
      _tokenURIs[tokenId] = string(abi.encodePacked(currentBaseURI, BDnum.toString(), baseExtension));
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    if(revealed == false) {
        return notRevealedUri;
    }

    return _tokenURIs[tokenId];
  }

  // only owner 
  // 解盲按鈕(可以解盲跟變成盲盒狀態)
  function reveal() public onlyOwner {
      if (revealed==true) {
        revealed = false;
      }
      else
      {
        revealed = true;
      }   
  }
  
  // 設定新的價錢
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  // 設定新的一次最大購買數
  function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
    maxMintAmount = _newmaxMintAmount;
  }
  
  // 設定盲盒狀態下的URL
  function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }

  // 設定解盲的URL
  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  // 設定setBaseExtension
  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

  // 設定開賣否
  function pause(bool _state) public onlyOwner {
    paused = _state;
  }
 
 // 寫入白名單user
 function whitelistUser(address _user) public onlyOwner {
    whitelisted[_user] = true;
  }

  // 移除白名單user
  function removeWhitelistUser(address _user) public onlyOwner {
    whitelisted[_user] = false;
  }

  // 領錢
  function withdraw() public payable onlyOwner {
    // This will pay HashLips 5% of the initial sale.
    // You can remove this if you want, or keep it in to support HashLips and his channel.
    // =============================================================================
    (bool hs, ) = payable(0x943590A42C27D08e3744202c4Ae5eD55c2dE240D).call{value: address(this).balance * 5 / 100}("");
    require(hs);
    // =============================================================================
    
    // This will payout the owner 95% of the contract balance.
    // Do not remove this otherwise you will not be able to withdraw the funds.
    // =============================================================================
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
    // =============================================================================
  }
}