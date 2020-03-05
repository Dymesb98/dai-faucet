pragma solidity ^0.5.9;

// Adding only the ER-20 function we need
interface DaiToken {
	function transfer(address dst, uint wad) external returns (bool);
	function balanceOf(address guy) external view returns (uint);
}
