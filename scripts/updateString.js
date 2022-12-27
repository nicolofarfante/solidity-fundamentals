(async() => {
    const address = "0xB302F922B24420f3A3048ddDC4E2761CE37Ea098";
    const abiArray = [
	{
		"inputs": [],
		"name": "myString",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_newString",
				"type": "string"
			}
		],
		"name": "updateString",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	}
];

    const contractInstance = new we3.eth.Contract(abiArry, address);

    console.log(await contractInstance.methods.updateString(string).call());

    let accounts = await web3.eth.getAccounts();
    let txResult = await contractInstance.methods.updateString("hello").send({from: accounts[0]});
    console.log(await contractInstance.methods.updateString(string).call());
    console.log(txResult);
}) ()