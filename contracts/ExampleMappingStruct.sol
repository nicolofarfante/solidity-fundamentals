// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Obiettivo è storare tutti i principali dati di ogni deposito/withdrawal
// Per farlo usiamo una combinazione di struct e mapping
contract MappingStructExample {

    //storiamo le transazioni, che siano depositi o withdrawal
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    //non storiamo il balance degli address in un semplice uint, vogliamo salvare più informazioni
    struct Balance {
        //aggiorniamo il balance quando avviene una transazione
        uint totalBalance;
        uint numOfDeposits;
        uint numOfWithdrawals;
        //salviamo i depositi nel mapping
        //  (l'uint qui indica il numero di deposito, ovvero 0 sarà il primo, 1 il secondo e così via...)
        mapping(uint => Transaction) deposits;
        //salviamo i withdrawal nel mapping
        //  (l'uint qui indica il numero di withdrawal, ovvero 0 sarà il primo, 1 il secondo e così via...)
        //  Correliamo quindi i dati di Transazione con un uint (il numero di withdrawal)
        mapping(uint => Transaction) withdrawals;
    }

    //mappo ogni address con un oggetto Balance che recupero dallo struct
    mapping(address => Balance) public balances;

    //se voglio vedere i dati di un deposito specifico
    function getDepositNum(address _from, uint _numOfDeposit) public view returns(Transaction memory) {
        return balances[_from].deposits[_numOfDeposit - 1];
    }

    function depositMoney() public payable {
        //accedo al totalBalance di un singolo address contenuto nel mapping "balances"
        // e ne incremento il valore
        balances[msg.sender].totalBalance += msg.value;

        //salvo la nuova transazione (in questo caso "deposit") nello struct delle transazioni
        Transaction memory deposit = Transaction(msg.value, block.timestamp);

        //voglio scrivere nel mapping "deposits": come chiave metto il valore della variabile "numOfDeposits" che ne 
        // stabilirà la posizione:
        // (al primo deposito il valore sarà 0, nel mapping "deposits" verrà salvata al primo posto e così via...)
        balances[msg.sender].deposits[balances[msg.sender].numOfDeposits] = deposit;

        // accedo dal mapping "balances" tramite address al Balance
        // dal Balance recupero la variabile "deposits" che è a sua volta un mapping
        // di "deposits" prendo l'uint di numero di depositi relativo ad un address
        // quindi:    .deposits[balances[msg.sender].numOfDeposits]
        // tutto questo diventa un nuovo oggetto Transaction chiamato "deposit" e salvato in memory con valore e timestamp  

        //incremento il numero di depositi, così che la prossima volta che chiamo la funzione depositMoney,
        // questo, ovvero    .deposits[balances[msg.sender].numOfDeposits]    sarà 1 in più
        balances[msg.sender].numOfDeposits++;
    }

    function withdrawMoney(address payable _to, uint _amount) public payable {
        
        balances[msg.sender].totalBalance -= _amount;
        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawals[balances[msg.sender].numOfWithdrawals] = withdrawal;
        balances[msg.sender].numOfWithdrawals;
        _to.transfer(_amount);

    }
}