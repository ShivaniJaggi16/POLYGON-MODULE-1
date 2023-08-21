// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "erc721a/contracts/ERC721A.sol";

contract Alien is ERC721A{

    address public owner;

    // Maximum number of tokens that can be minted
    uint256 public maxQuantity = 5;

    // Base url for the nfts
    string baseUrl = "https://gateway.pinata.cloud/ipfs/QmYjYsqcgwAqDZUwii7q2drgBVdoBDjcpHXxK1XGxKKTVR/";

    // URL for the prompt description
    string public prompt =
        "Alien versus a human";

    constructor() ERC721A("Alien", "ALI") {
        owner = msg.sender;
    }

    // Modifier that only allows the owner to execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this function");
        _;
    }

    // Function to mint NFT which only owner can perform
    function mint(uint256 quantity) external payable onlyOwner{
        require(totalSupply() + quantity <= maxQuantity ,"You can not mint more than 5");
        _mint(msg.sender, quantity);
    }

    // Override the baseURI function to return the base URL for the NFTs
    function _baseURI() internal view override returns (string memory){
        return baseUrl;
    }

    // Return the URL for the prompt description
    function promptDescription() external view returns (string memory) {
        return prompt;
    }
}
