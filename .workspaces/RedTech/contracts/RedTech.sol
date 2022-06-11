// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title RedTech
 */
contract RedTech {
    address  private owner;

    
    uint256  persentage = 5;
    
    // events for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event AmountTransferedTo(uint256 value, address indexed toAddress);
    event AmountRecievedFrom(uint256 amount);

    receive() external payable {}
    fallback() external payable {}

    
    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    
    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner returns (bool) {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
        return true;
    }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view isOwner returns (address)  {
        return owner;
    }

     /**
     * @dev Return contract balance 
     * @return balance of contract
     */
    function getBalance() external view isOwner returns (uint256)  {
        return address(this).balance;
    }
    

     /**
     * @dev User deposit eth to contract
     * @param amount amount payable
     * @param amount amount (in wei) to be transferred
     */
     function  deposit(uint256 amount)payable public returns (bool)  {
        require(msg.value == amount, "Incorrect amount");
        emit AmountRecievedFrom(amount);
        return true;
     }


    /**
     * @dev User withdraw amount from contract
     * @param amount amount to withdraw
     * @param amount amount (in wei) to be withdrawn
     */
     function  TransferAmountTo(uint256 amount, address user) payable public isOwner returns (bool) {
        payable(user).transfer(amount);
        emit AmountTransferedTo(amount, user);
        return true;
     }







}
