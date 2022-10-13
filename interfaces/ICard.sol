interface ICard {
  function approve ( address to, uint256 tokenId ) external;
  function balanceOf ( address owner ) external view returns ( uint256 );
  function changeUri ( string memory _uri ) external;
  function freeMint ( address account ) external;
  function getApproved ( uint256 tokenId ) external view returns ( address );
  function harvest ( address receiveAddress ) external;
  function isApprovedForAll ( address owner, address operator ) external view returns ( bool );
  function mint (  ) external;
  function name (  ) external view returns ( string memory);
  function owner (  ) external view returns ( address );
  function ownerOf ( uint256 tokenId ) external view returns ( address );
  function price (  ) external view returns ( uint256 );
  function renounceOwnership (  ) external;
  function safeTransferFrom ( address from, address to, uint256 tokenId ) external;
  function safeTransferFrom ( address from, address to, uint256 tokenId, bytes memory data ) external;
  function setApprovalForAll ( address operator, bool approved ) external;
  function supportsInterface ( bytes4 interfaceId ) external view returns ( bool );
  function symbol (  ) external view returns ( string memory);
  function tokenByIndex ( uint256 index ) external view returns ( uint256 );
  function tokenOfOwnerByIndex ( address owner, uint256 index ) external view returns ( uint256 );
  function tokenURI ( uint256 tokenId ) external view returns ( string memory);
  function totalSupply (  ) external view returns ( uint256 );
  function transferFrom ( address from, address to, uint256 tokenId ) external;
  function transferOwnership ( address newOwner ) external;
  function updatePrice ( uint256 _newPrice ) external;
}
