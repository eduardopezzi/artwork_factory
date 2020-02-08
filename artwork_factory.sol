pragma solidity ^0.5.16;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721Mintable.sol";

    contract Artist is ERC721Mintable {
        
        address public artist;
        // Collection of artworks by this Artist
        mapping(uint256 => ArtWork) public artworks;

        constructor() public {
            artist = msg.sender;
        }
        
        function createArtwork(uint256 hashIPFS, string memory artName) public returns (ArtWork) {
            require(msg.sender == artist, "only the artist can create Artwork");
            ArtWork artContract = new ArtWork(hashIPFS, artName, artist);
            artworks[hashIPFS] = artContract;
            return artContract;
        }
        
    }
       
    
    contract ArtWork is ERC721 {
        // Detail of artwork
        address public artist;
        string public name;
        uint public hashIPFS;
        address public owner;
    
        
        constructor(uint ipfsHash, string memory artName, address _artist) public {
            artist = msg.sender;
            name = artName;
            hashIPFS = ipfsHash;
            owner = _artist;
        }
    
  
        
        function _setOwner(address newOwner) public {
            require(owner == msg.sender, "only owner can transfer");
            owner = newOwner;
        }

    }
    
