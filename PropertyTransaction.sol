pragma solidity ^0.4.18;
contract PropertyTransaction {
/**This contract is a basic land registry program where Only
the contract initiator can assign properties to people may
be after
some document verification*/
Property[] properties; // registered properties
address landRegistryAdmin; //landRegistryAdmin is the user
who has initiated the contract
struct Property{
uint propertyId; // each property has an unique
propertyId
bytes32[] ownershipHistory; //Property ownership is a
historical data that has a seller, an owner/buyer and a
date of transaction
}
/**PropertySold is an event that informs on success or
failure of a transaction*/
event PropertySold(uint propertyId,
string ownership,
bool flag,
string message);



constructor() public {
landRegistryAdmin = msg.sender; // initiate the
landRegistryAdmin as the contract creator and initiate
some registered properties
Property memory property0 = Property(0, new bytes32[](0));
properties.push(property0);
properties[properties.length-1].ownershipHistory.
push("Buyer:b0, Seller:s0, DOT:dt0");
Property memory property1 = Property(1, new bytes32[](0));
properties.push(property1);
properties[properties.length-1].ownershipHistory.
push("Buyer:b1, Seller:s1, DOT:dt1");
Property memory property2 = Property(2, new bytes32[](0));
properties.push(property2);
properties[properties.length-1].ownershipHistory.
push("Buyer:b2, Seller:s2, DOT:dt2");
}

/**Land registration authority may alter ownership to any
of the existing properties*/
function addNewOwner(uint propertyId, bytes32 ownership)
public {
if (msg.sender != landRegistryAdmin) {
emit PropertySold(propertyId,
bytes32ToString(ownership),
false,
'Only land registry department
can assign ownership to buyer');
}

for (uint i = 0; i < properties.length; i++) {
if (properties[i].propertyId == propertyId) {
properties[i].ownershipHistory.push(ownership);
emit PropertySold(propertyId,
bytes32ToString(ownership),
true,
'New ownership added to existing
property');
break;
}
}
// propertyId does not exist in record, hence create a
new transaction and add to registered properties
Property memory property = Property(properties.length,
new bytes32[](0));
properties.push(property);
properties[properties.length-1].ownershipHistory.
push(ownership);
emit PropertySold(propertyId,
bytes32ToString(ownership),
true,
'New Property added');
}
function retrievePropertyHistory(uint propertyId) public
view returns(bytes32[]){
for (uint i = 0; i < properties.length; i++) {
if (properties[i].propertyId == propertyId) {
return properties[i].ownershipHistory;
}
}
}

function bytes32ToString(bytes32 x) private pure returns
(string) {
bytes memory bytesString = new bytes(32);
uint charCount = 0;
for (uint j = 0; j < 32; j++) {
byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
if (char != 0) {
bytesString[charCount] = char;
charCount++;
}
}
bytes memory bytesStringTrimmed = new bytes(charCount);
for (j = 0; j < charCount; j++) {
bytesStringTrimmed[j] = bytesString[j];
}
return string(bytesStringTrimmed);
}
}
