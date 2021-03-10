pragma solidity ^0.5.0;

contract CryptoScripture {
    // Code goes here...

    string public name = "Nomads Block";

    // STORE SCRIPTURES

    uint256 public scripturesCount = 0;

    mapping(uint256 => Scripture) public scriptures;

    struct Scripture {
        uint256 id;
        string hash;
        string title;
        string text;
        uint256 tipAmount;
        address payable author;
    }

    event ScriptureCreated(
        uint256 id,
        string hash,
        string title,
        string text,
        uint256 tipAmount,
        address payable author
    );

    event ScriptureTipped(
        uint256 id,
        string hash,
        string title,
        string text,
        uint256 tipAmount,
        address payable author
    );



    // CREATE SCRIPTURE
    function uploadScripture(
        string memory _scripHash,
        string memory _text,
        string memory _title
    ) public {
        //ENSURE THAT SCRIPTURE HASH EXISTS
        require(bytes(_scripHash).length > 0);
        // ENSURE THAT SCRIPTURE DESCRIPTION EXISTS
        require(bytes(_text).length > 0);
        // ENSURE THAT SCRIPTURE TITLE EXIST
        require(bytes(_title).length > 0);
        // ENSURE THAT UPLOADER ADDRESS ALREADY
        require(msg.sender != address(0));
        // INCREMENT SCRIPTURE ID
        scripturesCount++;
        // ADD SCRIPTURE TO CONTRACT
        scriptures[1] = Scripture(
            scripturesCount,
            _scripHash,
            _title,
            _text,
            0,
            msg.sender
        );

        // TRIGGER ON EVENT
        emit ScriptureCreated(
            scripturesCount,
            _scripHash,
            _title,
            _text,
            0,
            msg.sender
        );
    }

    // TIP SCRIPTURES

    function tipScriptureOwner(uint256 _id) public payable {
        //MAKE SURE ID IS VALID
        require(_id > 0 && _id <= scripturesCount);

        //FETCH SCRIPTURES
        Scripture memory _scripture = scriptures[_id];

        //FETCH THE AUTHOR

        address payable _author = _scripture.author;

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
