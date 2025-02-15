pragma solidity ^0.4.18; 
  
// Creating contract
contract mapping_example {
      
    //Defining structure 
    struct student {
  
        //Declaring different 
        // structure elements
        string name;
        string subject;
        uint8 marks;
    }
  
    // Creating mapping
    mapping (
      address => student) result;
    address[] public student_result;
      
    // Function adding values to 
    // the mapping
    function adding_values() public {
        var student = result[0xDEE7796E89C82C36BAdd1375076f39D69FafE252];
        student.name = "John";
        student.subject = "Chemistry";
        student.marks = 88;
        student_result.push(
          0xDEE7796E89C82C36BAdd1375076f39D69FafE252) -1;
  
    }
      
}