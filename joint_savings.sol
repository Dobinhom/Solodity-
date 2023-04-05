contract JointSavings {
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

      function withdraw(uint amount, address payable recipient) public {
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds!");
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }
        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

     function deposit() public payable {
        contractBalance = address(this).balance;
    }

      function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

      fallback() external payable {
        contractBalance = address(this).balance;
    }
}

setAccounts(0x0c0669Cd5e60a6F4b8ce437E4a4A007093D368Cb, 0x7A1f3dFAa0a4a19844B606CD6e91d693083B12c0);

uint balance = JointSavings.contractBalance();