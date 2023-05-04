// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TodoList {
    struct TodoItem {
        string task;
        bool isComplete;
    }

    mapping (uint256 => TodoItem) public list;
    uint256 public count = 0;
    address public owner;
    event TaskComplete(uint256 indexed id);

    constructor () {
        owner = msg.sender;
    }

    function addTask(string memory _task) onlyOwner public {
        TodoItem memory item = TodoItem({ task: _task, isComplete: false });
        list[count] = item;
        count++;
    }

    function completeTask(uint256 id) onlyOwner public {
        if (!list[id].isComplete) {
            list[id].isComplete = true;
            emit TaskComplete(id);
        }
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can call this");
        _;
    }
}