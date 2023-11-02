//Stone Token

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";



contract myToken is ERC20, ERC20Burnable {
    // declare owner var
    address payable public owner;
    uint256 public blockReward;

    constructor(uint256 cap, uint256 reward) ERC20("StoneToken","STN") ERC20Capped(cap * (10 ** decimals())){
        owner = msg.sender;
        // decimals is hardcoded in as uint 18
        _mint(owner, 50 * (10 ** decimals()));
        blockReward = reward * (10 ** decimals());
    }

    // interal function means can only be called within the contract
    function mintMinerReward() interal{
        // _mint just declares that we're calling from an inherited contract
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override{
        // address(0) is just a valid address
        if(from != address(0)) && to != block.coinbase && block.coinbase != address(0){
            mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
        
    }

    function destroy() public onlyOwner{
        selfdestruct(owner);
    }

    function setBlockReward(uint256 reward) public onlyOwner{
        blockReward = reward * (10**decimals());
    }

    // access modifier to implement in block reward so only they can edit

    modifier onlyOwner{
        require(msg.sender == owner, "only owner can call this function");
        _;
    }
}