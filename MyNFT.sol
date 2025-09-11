// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 导入OpenZeppelin的ERC721库
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata"
contract MyNFT is ERC721,Ownable {
    // 跟踪下一个要铸造的token ID
    uint256 private _nextTokenId;

    mapping(uint256 => string) private _tokenUris;

    // 构造函数：设置NFT名称和符号
    constructor(string memory name,string memory symbol, address initialOwner) ERC721(name, symbol) Ownable(initialOwner) {
        _nextTokenId = 1;// 从1开始编号
    }

    // 铸造NFT函数
    function mintNFT(address recipient, string memory uri) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        super._mint(recipient, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    // function _safeMint(address to,uint256 tokenId,bytes memory data) internal virtual override(ERC721) {
    //     super._safeMint(to,tokenId,data);
    // }

    // 重写tokenURI函数
    function tokenURI(uint256 tokenId) public view virtual override(ERC721) returns (string memory)
    {
        require(_exists(tokenId), "Token does not exist");
        string memory uri = _tokenUris[tokenId];
        return uri;
    }

    function _exists(uint256 tokenID) internal view returns (bool) {
        address owner = ownerOf(tokenID);
        if (owner == address(0)) {
            return false;
        }
        return true;
    }

    function _baseURI() internal view virtual override(ERC721) returns (string memory) {
        string memory baseurl = "https://ipfs.io/ipfs/";
        return baseurl;
    }

    function _setTokenURI(uint256 tokenId,string memory uri) internal {
        require(_exists(tokenId), "Token does not exist");
        _tokenUris[tokenId] = uri;
    }
}
    