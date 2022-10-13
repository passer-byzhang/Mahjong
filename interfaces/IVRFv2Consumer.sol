pragma solidity ^0.8.7;
interface IVRFv2Consumer {
  function acceptOwnership (  ) external;
  function getRequestStatus ( uint256 _requestId ) external view returns ( bool fulfilled, uint256[] memory randomWords );
  function lastRequestId (  ) external view returns ( uint256 );
  function owner (  ) external view returns ( address );
  function rawFulfillRandomWords ( uint256 requestId, uint256[] memory randomWords ) external;
  function requestIds ( uint256 ) external view returns ( uint256 );
  function requestRandomWords (  ) external returns ( uint256 requestId );
  function s_requests ( uint256 ) external view returns ( bool fulfilled, bool exists );
  function transferOwnership ( address to ) external;
}
