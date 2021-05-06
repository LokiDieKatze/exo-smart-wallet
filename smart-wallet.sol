// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SmartWallet {
    address private owner;
    
    mapping(address => uint256) private _balances;

    constructor (address account, uint256 fee) {
        owner = account;
        fee = 1/100;
    }
    
    function whoIsOwner() public view returns (address) {
    //    log();
        return owner;
    }
    
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
    }
    
    // Exerice 1: 
    // Implementer une fonction withdrawAmount pour permettre à un utilisateur
    // de récupérer un certain amount de ses fonds
    function withdrawAmount(uint256 amount, uint256 fee) public {
        require(_balances[msg.sender] >= amount, "SmartWallet: can not withdraw more ether than available");
        _balances[msg.sender] -= (amount);
        _balances[owner] += amount/fee;
        payable(msg.sender).transfer(amount - amount/fee);
        // payable(owner).transfer(amount/fee);
    }
    
    // Exercice 2:
    // Implementer une fonction transfer pour permettre à un utilisateur d'envoyer
    // des fonds à un autre utilisateur de notre SmartWallet
    // ATTENTION on effectue pas un vrai transfer d'ETHER, 
    // un transfer n'est qu'une ecriture comptable dans un registre
    function transfer(address account, uint256 amount) public {
        require(_balances[msg.sender] >= amount, "SmartWallet can not transfer more ether than available");
        require(_balances[account] >= 0, "SmartWallet can not find receiver address");
        _balances[msg.sender] -= amount;
        _balances[account] += amount;
        payable(account).transfer(amount);
    }
    
    function withdraw(uint256 fee) public {
        require(_balances[msg.sender] > 0, "SmartWallet: can not withdraw 0 ether");
        uint256 amount = _balances[msg.sender];
        _balances[msg.sender] = 0;
        _balances[owner] += amount/fee;
        payable(msg.sender).transfer(amount - amount/fee);
    }
    
    function viewFee(uint256 fee) public view returns (uint256) {
        return fee;
    }
    
    function total() public view returns (uint256) {
        return address(this).balance;
    }
    
     
}