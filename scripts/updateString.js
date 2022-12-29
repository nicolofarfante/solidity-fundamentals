(async() => {
    const address = "0x1482717Eb2eA8Ecd81d2d8C403CaCF87AcF04927";
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

    const contractInstance = new web3.eth.Contract(abiArray, address);

    console.log(await contractInstance.methods.myString().call());

    let accounts = await web3.eth.getAccounts();
    let txResult = await contractInstance.methods.updateString("hello").send({from: accounts[0]});
    console.log(await contractInstance.methods.myString().call());
    console.log(txResult);
}) ()