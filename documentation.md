# Haskell miniproject
> _Daniel Moesgaard Andersen_ \
_20164256_ \
_dand16@student.aau.dk_


## Status of the program
The program is able to generate a list of tuples describing how many times a given character appears in the input string with the function "countLetters". \
This can then be used input in the makeEncodingTree function, which will generate a Huffman tree using the user-defined type *tree*, where the most frequently occurring characters will be put in the top of the tree.\
The tree consists of the two type synonyms Symbol and Weight for respectively Char and Int to make the program more readable.\
This tree can now be used as input along with a string for the encode and decode functions.\
It is able to generate the same tree as given in the video linked in the project description, but the program is not truly able to take an arbitrary text as input, only characters ranging from the space character to z.\
In order to fix this, the program should iterate through the characters in the input string, rather than going through every single character defined in the list comprehension.


## External parts and inspiration
The primary inspiration for creating the program has been the video [Text Compression with Huffman Coding](https://www.youtube.com/watch?v=iiGZ947Tcck&feature=youtu.be) along with the Introduction to Algorithms book.\
In addition to this, some inspiration for the sortedInsert function was found on StackOverflow.

## Non-completed tasks
None of the extended solutions have been implemented.\
It would also be possible manually implement a sorting algorithm, rather than using the sortOn function from Data.List, however, since it is implemented in Haskell, it seemed like a good opportunity to try using imports.
