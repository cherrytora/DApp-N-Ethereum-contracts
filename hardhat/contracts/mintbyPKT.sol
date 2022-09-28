// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import './PokenTest.sol';

contract mintbyPKT is ERC721Enumerable, Ownable {
  using Strings for uint256;

  string public baseURI;
  string public baseExtension = ".json";
  uint256 public maxSupply = 100; 
  uint256 public maxMintAmount = 5; 
  bool public paused = false; 
  bool public revealed = false; 
  string public notRevealedUri; 
  uint private _rand = 3; 
  mapping(address => bool) public whitelisted;
  mapping(uint256 => string) private _tokenURIs;
  // 設定一個盲盒的價錢
  uint256 public price = 513;

  // 把PKT接過來
  PokenTest public PKT;

  constructor(
    string memory _initBaseURI,
    string memory _initNotRevealedUri
  ) ERC721("mintbyPKT2", "MBPKT2") {
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
    // 把PKT接過來
    PKT = PokenTest(0x73715Ec8e26FF669F246753699e618871E430f52);
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public
  function mint(uint256 _mintAmount) public {
    uint256 supply = totalSupply();
    require(!paused);
    require(_mintAmount > 0);
    require(_mintAmount <= maxMintAmount);
    require(supply + _mintAmount <= maxSupply);
    // 確認PKT額度
    require(PKT.allowance(msg.sender, address(this)) >= price * _mintAmount, "Not enough of PKT");
    
    // 把PKT從msg.sender轉到這個合約裡
    PKT.transferFrom(msg.sender, address(this), price * _mintAmount);

    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(msg.sender, supply + i);
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
  function reveal() public onlyOwner {
      if (revealed==true) {
        revealed = false;
      }
      else
      {
        revealed = true;
      }   
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
  function withdraw() public onlyOwner {
    PKT.transfer(msg.sender, PKT.balanceOf(address(this)));
  }
}