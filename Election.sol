pragma solidity ^0.4.21;

contract Election {
    struct Candidate{
        string name;
        uint voteCount;
    }
    
    struct Voter{
        bool authorized;
        bool voted; // true if alredy voted 
        uint vote; //who did you vote for: the Candidate # you voted for  
    }
    
    
    address public owner ; //Who will own this contract
    string public electionName; // Any name for the election 
    
    mapping(address => Voter) public voters; //Define a map that will holder  "Voter" type of objects
    Candidate[] public canditates;
    
    uint public totalVotes;
    
    modifier ownerOnly() {
        require(msg.sender == owner);
        _; 
    }
    
    
    function Election (string _name) public {
        owner = msg.sender;
        electionName = _name;
    }
    
    function addCandidate(string _name) ownerOnly public {
        canditates.push(Candidate(_name, 0));
    }
    
    function getNumCandidate() public view returns (uint){
        return canditates.length;
    }
    
    function authorize (address _person) ownerOnly public {
        voters[_person].authorized  = true;
    }
    
    function vote(uint _voteIndex) public {
        require(!voters[msg.sender].voted);
        require(voters[msg.sender].authorized==true);
        
        
        
        voters[msg.sender].vote = _voteIndex;
        voters[msg.sender].voted=true;
        
        canditates[_voteIndex].voteCount += 1;
        totalVotes += 1;
        
    }
    
    function end() ownerOnly public {
        selfdestruct(owner);
    }
}

