//Stone Token

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract myToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("myToken","MT"){
        _mint(msg.sender, initialSupply);
    }
  
}