// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MappingStructExample {

    //obiettivo è storare tutti i principali dati di ogni deposito/withdrawal
    // per farlo, usiamo una combinazione di struct e mapping

    struct Transaction {
        //storiamo le transazioni, che siano depositi o withdrawal
        uint amount;
        uint timestamp;
    }

    struct Balance {
        //non storiamo il balance in un semplice uint in quanto vogliamo salvare più informazioni
        //aggiorniamo il balance quando avviene una transazione

        uint totalBalance;

        uint numOfDeposits;
        //salviamo i depositi nel mapping
        //  (l'uint qui indica il numero di deposito, ovvero 0 sarà il primo, 1 il secondo e così via...)
        mapping(uint => Transaction) deposits;

        uint numOfWithdrawals;
        //salviamo i withdrawal nel mapping
        //  (l'uint qui indica il numero di withdrawal, ovvero 0 sarà il primo, 1 il secondo e così via...)
        mapping(uint => Transaction) withdrawals;
    }

    //mappo ogni address con un oggetto Balance
    mapping(address => Balance) balances;

    function depositMoney() public payable {
        //accedo al totalBalance di un singolo address contenuto nel mapping "balances"
        // e ne incremento il valore
        balances[msg.sender].totalBalance += msg.value;

        //salvo la nuova transazione (in questo caso "deposit" nello struct delle transazioni)
        Transaction memory deposit = Transaction(msg.value, block.timestamp);

        //voglio scrivere nel mapping "deposits": come chiave metto il valore della variabile "numOfDeposits" che ne stabilirà la posizione:
        // (al primo deposito il valore sarà 0, nel mapping "deposits" verrà salvata al primo posto e così via...)
        balances[msg.sender].deposits[balances[msg.sender].numOfDeposits] = deposit;

        //incremento il numero di depositi, così che la prossima volta che chiamo la funzione depositMoney,
        // questo, ovvero    .deposits[balances[msg.sender].numOfDeposits]    sarà 1 in più
        balances[msg.sender].numOfDeposits++;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        
    }
}