#TruffleWebPack Intro For upgradeable Smart Contract

https://vomtom.at/upgrade-smart-contracts-on-chain/

1. truffle unbox webpack 
    1.1 Add MetaCoinStorage
    1.2 Add MetaCoin.sol (For the sake of this example this contract has a bug in it):

        	function getBalance(address addr) public view returns(uint) {
		            return metaCoinStorage.getBalance(addr) + 10;
	        }

    1.3 In 2_deploy_Storage.js -> Deploy the storage contract
    1.4 In 3_deploy_MetaCoin.js -> Deploy Contract Leveraging storage from (storage contract)

2. truffle develop
3. compile
4. migrate
5. Execute Transactions with the buggy contract:
    5.1 MetaCoin.deployed().then(inst => { return inst.getBalance.call(web3.eth.accounts[0]);}).then(bigNum => { return bigNum.toNumber();});
    5.2 MetaCoin.deployed().then(inst => { return inst.sendCoin(web3.eth.accounts[1], 5000);});
    5.3 MetaCoin.deployed().then(inst => { return inst.getBalance.call(web3.eth.accounts[0]);}).then(bigNum => { return bigNum.toNumber();});
    5.4 Notice how the contract always returns back balance with +10 bug
6. Update MetaCoin.sol and remove +10 
7. compile 
8. migrate -f 3 (which migrates the third script)
9. The bug is now removed:
    MetaCoin.deployed().then(inst => { return inst.getBalance.call(web3.eth.accounts[0]);}).then(bigNum => { return bigNum.toNumber();});


One additional point to note is only the latest contract should have access to the storage of Eternal Storage See here:
https://gist.githubusercontent.com/darcius/6e8fa4faa6d9139f3950b6f1d9e96038/raw/b9aaafa1ee6dec06e0c87f7e7d2c83375cc07fbd/RocketStorage.sol        