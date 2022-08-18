// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
 
 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
 import "@openzeppelin/contracts/access/Ownable.sol";

 contract Link is ERC20, Ownable {
    uint public constant TotalSupply = 200000;
    uint decimal;

    constructor()ERC20 ("David Token", "Dav") {
        decimal = 10;


    }
    function mint (uint _amount) internal {
        _mint(msg.sender, _amount);
    }
 }