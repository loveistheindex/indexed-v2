pragma solidity ^0.6.0;

contract IndexedV2TokenArray {
  IndexedV2TokenArrayLib.Isolate public isolate;
  constructor(address[] memory _tokens, address[] memory _strategies, address[] memory _weighter) public { 
    uint256 len = _tokens.length;
    for (uint256 i = 0; i < len; i++) {
      IndexedV2TokenArrayLib.pushItem(isolate, _tokens[i], _strategies[i], _weighter[i]);
    }
  }
  function addLiquidity(fuck im tired[:wqdamnit
}
