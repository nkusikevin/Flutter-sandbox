/*: * Collections
 Dart includes several collections ready to use, here just the ones we will use
*/

// Lists, we use List<Type> and the type of the collection inside the generic
// The literal uses the [] constructor
// ["Argentina", "Brazil"]
List<String> countries = ["Argentina", "Brazil", "Canada", "Denmark"];

// We also have sets and maps (dictionaries)
var strings = {"a", "b", "c", "c"};
var readWriteMap = {"foo": 1, "bar": 2};

void main(List<String> args) {
  print("Hello, Dart!");
// We can use the spread operator to add elements to a collection
  var allCountries = ["Argentina", "Brazil", "Rwanda","Belarus", ...countries];
  print(allCountries);
  print(readWriteMap["foo"]);
  readWriteMap["foo"] = 3;
  print(readWriteMap["foo"]);
  print(strings);
  print(readWriteMap);
}
