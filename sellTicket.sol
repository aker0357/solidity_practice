pragma solidity ^0.4.18;


contract TEMTicket {
    uint256 constant public FEE = 0.015 ether;

    mapping (uint256 => address) public id2Addr;
    mapping (address => uint256[]) public userId;
    address public TEMWallet;
    uint256 public userAmount;
    uint256 public maxAttendees;
    uint256 public startTime;
    uint256 public stopTime;

    function TEMTicket(address _TEMWallet, uint256 _maxAttendees, uint256 _startTime, uint256 _ableTime) public {
        TEMWallet = _TEMWallet;
        maxAttendees = _maxAttendees;
        userAmount = 0;
        startTime = _startTime;
        stopTime = _startTime + _ableTime;
    }

    function () payable external {
        getTicket(msg.sender);
    }

    function getTicket (address _attendee) payable public {
        require(now >= startTime && msg.value >= FEE );
        userAmount ++;
        require(userAmount <= maxAttendees);
        userId[_attendee].push(userAmount);
        id2Addr[userAmount] = _attendee;
    }

    function withdraw () public {
        TEMWallet.transfer(this.balance);
    }
}