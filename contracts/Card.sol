// SPDX-License-Identifier: BUSL-1.1

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Card is ERC721Enumerable, Ownable{
    
    Counters.Counter private _tokenIdTracker;

    uint public price = 0.01 ether;

    string private uri;

    address mahjong;

    event UpdatePrice(uint, uint);

    event UpdateUri(string, string);

    constructor(string memory _name, string memory _symbol, string memory _uri) ERC721(_name, _symbol){
        uri = _uri;
    }

    ///管理员修改uri
    function changeUri(string memory _uri) external onlyOwner {
        string memory _old = uri;
        uri = _uri;
        emit UpdateUri(_old, _uri);
    }

    ///管理员修改uri
    function changeMahjong(address _mahjong) external onlyOwner {
        mahjong = _mahjong;
    }

    /// 在这里填写 token 的基础uri
    function _baseURI() internal view override returns (string memory) {
        return uri;
    }

    ///重载_beforeTokenTransfer保证不能transfer
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId);
        if (from != address(0)) {
            require(false, "Forbidden");
        } else  {
        }

    }

    ///管理员可以设置价格
    function updatePrice(uint _newPrice) external onlyOwner{
        uint _old = price;
        price = _newPrice;
        emit UpdatePrice(_old, _newPrice);

    }

    ///管理员可以免费mint
    function freeMint(address account) external onlyOwner {
        uint256 tokenId = Counters.current(_tokenIdTracker);
        _safeMint(account, tokenId);
        Counters.increment(_tokenIdTracker);
    }

    //管理员可以将合约里面的钱提取出来
    function harvest(address payable receiveAddress) external onlyOwner {
        receiveAddress.transfer(address(this).balance);
    }

    function mint() external {
        require(msg.sender == mahjong, "permission deny");
        uint256 tokenId = Counters.current(_tokenIdTracker);
        _safeMint(msg.sender, tokenId);
        Counters.increment(_tokenIdTracker);
    }

}