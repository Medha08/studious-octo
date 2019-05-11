pragma solidity >=0.4.24 <0.6.0;

import "node_modules/zos-lib/contracts/Initializable.sol";

contract LinkedList is Initializable{

  event EntryAdded(bytes32 head,string data,bytes32 next);
  //struct will be our node
  struct Node{
    bytes32 next;
    string data;
  }

 //Mapping will hold nodes
  mapping(bytes32 => Node) public nodes;

  //Length of LinkedList (initialize with constructor/initalizer)
  uint public length;
  //Head of list
  bytes32 public head;

  string public listName;

  function initialize(string memory _listname) public initializer  {
    require(bytes(_listname).length >= 0,"Invalid Length");
    length = 0;
    listName = _listname;
  }

  function addNode(string memory _data) public returns(bool){
    Node memory node = Node(head,_data);
    bytes32 id = keccak256(abi.encodePacked(node.data,length,block.timestamp));

    nodes[id] = node;
    head = id;
    length = length + 1;

    emit EntryAdded( head,node.data, node.next);

  }

  function popNode()public returns(bool){
    require(length > 0,"error...head is empty ");
    bytes32 newHead = nodes[head].next;

    delete nodes[head];
    head = newHead;
    length = length - 1;
  }

  function getNodeExternal()external view returns(bytes32 , string memory){
    return (nodes[head].next,nodes[head].data);
  }


}