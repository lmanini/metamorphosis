pragma solidity ^0.8.19;

import "../src/Factory.sol";

contract FactoryDeployer {

    function deploy(bytes32 salt) external returns(Factory) {
        return new Factory{salt: salt}(); // deploy with CREATE2
    }
}