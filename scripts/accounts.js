//Anonymous function
(async() => {
    let accounts = await web3.eth.getAccounts();
    console.log(accounts);
    let balance = await web3.eth.getBalance(accounts[0]);
    console.log(balance);
    let balanceInEth = await web3.util.fromWei(balance.toString(), "ether");
    console.log(balanceInEth);
})()

//equivalente di scrivere la funzione () e il suo body {} e poi di richiamarla ()
/*
    function main() {
        asdfghk...
    }
    main();
*/
