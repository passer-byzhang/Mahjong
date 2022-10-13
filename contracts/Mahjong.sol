pragma solidity >=0.8.0;
import "../interfaces/IVRFv2Consumer.sol";
import "../interfaces/ICard.sol";
contract Mahjong{

    address VRF_ADDRESS;
    address CARD_ADDRESS;
    uint price;

    enum CardType{
        m,// code:0-35
        p,// code: 36-71
        s,// code: 72-107 
        w,// code: 107-122
        z// code: 122-134
    }
    struct Card {
        CardType cardType;
        uint cardId;
    }

    mapping(address=>Card[]) handCard;

    function removeCard(uint code) external{
        Card[] storage cards = handCard[msg.sender];
        Card memory card = _generateCard(code);
        require(cards.length==14, "2");
        for(uint i=0; i< cards.length; i++){
            if(cards[i].cardType == card.cardType && cards[i].cardId == card.cardId){
                delete cards[i];
                break;
            }
        }
    }

    function buyCard() public payable {
        require(msg.value >= price, "not enough");
        Card[] storage cards = handCard[msg.sender];
        require(cards.length<14,"invalid hand cards");
        cards.push(_getRandomCard());
    }

    function updatePrice(uint newPrice) external {
        price = newPrice;
    }

    function _generateCard(uint code) internal pure returns (Card memory) {
        require(code>=0&&code<=135, "invalid code");
        CardType cardType;
        uint cardId;
        if(code<=35){
            cardType = CardType.m;
            cardId = code%9 + 1;
        }else if(code<=71){
            cardType = CardType.p;
            cardId = (code - 71)%9 + 1;
        }else if(code<=107){
            cardType = CardType.s;
            cardId = (code - 107)%9 + 1;
        }else if(code<=122){
            cardType = CardType.w;
            cardId = (code - 107)%4 + 1;
        }else{
            cardType = CardType.z;
            cardId = (code - 122)%3 + 1;
        }
        return Card(cardType,cardId);
    }



    constructor(address vrf){
        VRF_ADDRESS = vrf;
    }

    modifier isValidCard(Card memory card) {
        if(card.cardType == CardType.m||card.cardType == CardType.p||card.cardType == CardType.s){
            require(card.cardId>=1&&card.cardId<=9, "invalid card");
        }
        else if(card.cardType == CardType.w){
            require(card.cardId>=1&&card.cardId<=4, "invalid card");
        }
        else{
            require(card.cardId>=1&&card.cardId<=3, "invalid card");
        }
        _;
    }

    function _getRandomCard()internal returns (Card memory)  {
        uint random = IVRFv2Consumer(VRF_ADDRESS).requestRandomWords();
        return _generateCard(random%135);
    }

    function sell() external {
        if(point() >= 1){
            ICard(CARD_ADDRESS).mint();
        }
    }


    function point() internal view returns (uint256) {
        Card[] memory cards = handCard[msg.sender];
        
        return cards.length;
    }










}