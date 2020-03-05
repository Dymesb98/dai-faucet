pragma solidity ^0.5.9;

import "./DaiToken.sol";

contract Owned is DaiToken {
	DaiToken daitoken;
	address owner;

	constructor() public {
			owner = msg.sender;
			daitoken = DaiToken(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
	}

	modifier onlyOwner {
			require(msg.sender == owner, "Only the contract owner can call this function");
			_;
	}
}
