pragma solidity ^0.8.19;

import "../src/FactoryDeployer.sol";
import "../src/Factory.sol";
import "../src/BadImplementation.sol";
import "../src/GoodImplementation.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract Metamorphosis is Test {

    FactoryDeployer factoryDeployer;
    Factory factory;

    BadImplementation bad;
    GoodImplementation good;

    bytes32 salt;

    /**
     * Because of how `selfdestruct` works, I have to put the .kill()s at the
     * end of the test set up, so that selfdestruct is actually able to erase
     * the whole state of the destroyed accounts.
     */
    function setUp() external {
        salt = bytes32(hex"deadbeef");
        factoryDeployer = new FactoryDeployer();

        factory = factoryDeployer.deploy(salt);
        good = factory.deployGoodContract();

        vm.label(address(factoryDeployer), "FactoryDeployer");
        vm.label(address(factory), "Factory");
        vm.label(address(good), "GoodImplementation");

        // Contract is a good contract
        string memory res = good.what();
        console.log(res);

        /// Start metamorphosis
        good.kill();
        factory.kill();
    }

    function test_Metamorphosis() external {
        
        factoryDeployer.deploy(salt);

        bad = factory.deployBadContract();
        string memory res = bad.what();
        console.log(res);

        assertEq(address(good), address(bad));
    }    
}