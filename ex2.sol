pragma solidity ^0.5.0;

contract test {
   enum FreshJuiceSize{ SMALL, MEDIUM, LARGE }
   FreshJuiceSize choice;
   FreshJuiceSize constant defaultChoice = FreshJuiceSize.MEDIUM;

   function setLarge() public {
      choice = FreshJuiceSize.LARGE;
   }
   function setSmall() public {
       choice = FreshJuiceSize.SMALL;
   }
   function getChoice() public view returns (FreshJuiceSize) {
      return choice;
   }

}