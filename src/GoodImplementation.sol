pragma solidity ^0.8.19;

contract GoodImplementation {

    function what() pure external returns(string memory) {
        return unicode"I'm a good contract 😘";
    }

    function kill() external {
        selfdestruct(payable(address(0x69)));
    }

}