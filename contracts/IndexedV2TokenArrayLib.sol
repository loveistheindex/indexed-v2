pragma solidity ^0.6.0;

library IndexedV2ArrayLib {
  struct IndexItem {
    address token;
    address strategy;
  }
  struct Isolate {
    IndexItem[] public indexed;
    mapping (address => uint256) indexedByToken;
  }
  function zipIndexItem(address token, address strategy, address weighter) internal pure returns (IndexItem memory result) {
    result.token = token;
    result.strategy = strategy;
    result.weighter = weighter;
  }
  function getIndex(Isolate storage isolate, address token) internal view returns (uint256 result) {
    result = ~isolate.indexedByToken[token]; // just negate it so we store uint256(-1) when it's supposed to be 0, and we don't read 0 values that are actually uninitialized like idiots
  }
  function setIndex(Isolate storage isolate, address token, uint256 index) internal {
    isolate.indexedByToken[token] = ~index;
  }
  function lookupItem(Isolate storage isolate, address token) internal view returns (bool success, IndexItem storage result) {
    uint256 index = getIndex(isolate, token);
    if (index != 0) {
      success = true;
      result = isolate.indexed[index];
    }
  }
  function lookupItemOrThrow(Isolate storage isolate, address token) internal view returns (IndexItem storage result) {
    (bool success, result) = lookupItem(isolate, token);
    require(success, "IndexedV2TokenArray::lookupItem: failure to find token");
  }
  function pushItem(Isolate storage isolate, address token, address strategy, address weighter) internal {
    isolate.indexed.push(IndexedV2TokenArrayLib.IndexItem({
      strategy: strategy,
      token: token,
      weighter: weighter
    }));
    isolate.indexedByToken[token] = strategy;
  }
  function getStrategy(IndexItem storage item) internal view returns (IStrategy result) {
    result = IStrategy(item.strategy);
  }
}
