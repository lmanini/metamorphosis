pragma solidity ^0.8.19;

import "../src/BadImplementation.sol";
import "../src/GoodImplementation.sol";

contract Factory {

    function deployGoodContract() external returns(GoodImplementation) {
        return new GoodImplementation(); // deploy with CREATE
    }

    function deployBadContract() external returns(BadImplementation) {
        return new BadImplementation(); // deploy with CREATE
    }

    function kill() external {
        selfdestruct(payable(address(0x69)));
    }
}