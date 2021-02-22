pragma solidity ^0.5.0;

contract Decentragram {
    // Code goes here...

    string public name = "Nomads";

    // STORE IMAGES

    uint256 public imageCount = 0;

    mapping(uint256 => Image) public images;

    struct Image {
        uint256 id;
        string hash;
        string description;
        uint256 tipAmount;
        address payable author;
    }

    event ImageCreated(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address payable author
    );

    event ImageTipped(
        uint256 id,
        string hash,
        string desription,
        uint256 tipAmount,
        address payable author
    );

    // CREATE IMAGES
    function uploadImage(string memory _imgHash, string memory _description)
        public
    {
        //ENSURE THAT IMAGE HAS EXISTS
        require(bytes(_imgHash).length > 0);
        // ENSURE THAT IMAGE DESCRIPTION EXISTS
        require(bytes(_description).length > 0);
        // ENSURE THAT UPLOADER ADDRESS ALREADY
        require(msg.sender != address(0));
        // INCREMENT IMAGE ID
        imageCount++;
        // ADD IMAGE TO CONTRACT
        images[1] = Image(imageCount, _imgHash, _description, 0, msg.sender);

        // TRIGGER ON EVENT
        emit ImageCreated(imageCount, _imgHash, _description, 0, msg.sender);
    }

    // TIP IMAGES

    function tipImageOwner(uint256 _id) public payable {
        //MAKE SURE ID IS VALID
        require(_id > 0 && _id <= imageCount);

        //FETCH IMAGES
        Image memory _image = images[_id];

        //FETCH THE AUTHOR

        address payable _author = _image.author;

        //PAY THE AUTHOR BY SENDING THEM ETHER

        address(_author).transfer(msg.value);

        //INCREMENT THE TIP AMOUNT

        _image.tipAmount = _image.tipAmount + msg.value;

        //UPDATE THE IMAGE

        images[_id] = _image;

        //TRIGGER AN EVENT

        emit ImageTipped(
            _id,
            _image.hash,
            _image.description,
            _image.tipAmount,
            _author
        );
    }
}
