pragma solidity ^0.4.0;
contract coin_toss {
    address public p1_address;
    address public p2_address;
    bytes32 public p1_hash ;
    bytes32 public p2_hash ;
    uint public p1_preimage = 0;
    uint public p2_preimage = 0;
    int public num_players = 0;

    /// Create a new ballot with $(_numProposals) different proposals.
    function ante(bytes32 hash) public payable {
        //check if player sent 1 eth
        require(msg.value == 1000);
        require(num_players < 2);
        // check number of players
        if (num_players == 0){
            //assign player 1
            p1_address = msg.sender;
            p1_hash = hash;
            num_players ++;
        }
        if (num_players == 1 && p1_address != msg.sender){
            p2_address = msg.sender;
            p2_hash = hash;
            num_players ++;
        }

    }

    function reveal(uint _pre_image) public returns (string _settled){
        // Check that pre_image is valid to previously submitted hash.
        _settled = "no";
        require((sha256(_pre_image) == p1_hash) || (sha256(_pre_image) == p2_hash));
        if (msg.sender == p1_address) {
            p1_preimage = _pre_image;
        }
        if (msg.sender == p2_address) {
            p2_preimage = _pre_image;
        }
        if (p1_preimage != 0 && p2_preimage != 0){
            settle();
            _settled = "yes";
        }
    }

    function settle() private {
        // If pre_images mod 2 are even, send to player 1
        if (p1_preimage + p2_preimage % 2 == 0){
            p1_address.transfer(2);
        }
        else{
            p2_address.transfer(2);
        }
    }

    function hash(uint _pre_image) public
    returns (bytes32 hash) {
        hash = sha256(_pre_image);
    }
}
