pragma solidity ^0.4.24;

import "./ConvertLib.sol";
import "./MetaCoinStorage.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
	MetaCoinStorage metaCoinStorage;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor(address metaCoinStorageAddress) public {
		metaCoinStorage = MetaCoinStorage(metaCoinStorageAddress);
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		uint256 senderBal = metaCoinStorage.getBalance(msg.sender);
		uint256 receiverBal = metaCoinStorage.getBalance(receiver);
		if (senderBal < amount) return false;
		senderBal -= amount;
		receiverBal += amount;
		metaCoinStorage.setBalance(msg.sender,senderBal);
		metaCoinStorage.setBalance(receiver,receiverBal);
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return metaCoinStorage.getBalance(addr) + 10;
	}
}
