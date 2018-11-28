<?php

$info = array('coffee', 'brown', 'caffeine');

// Listing all the variables
list($drink, $color, $power) = $info;
echo "$drink is $color and $power makes it special.\n";

// Listing some of them
list($drink, , $power) = $info;
echo "$drink has $power.\n";

// Or let's skip to only the third one
list( , , $power) = $info;
echo "I need $power!\n";

// list() doesn't work with strings
list($bar) = "abcde";
var_dump($bar); // NULL

while (list($id, $name, $salary) = $result->fetch(PDO::FETCH_NUM)) {}

list($a, list($b, $c)) = array(1, array(2, 3));

$info = array('coffee', 'brown', 'caffeine');
list($a[0], $a[1], $a[2]) = $info;

list("id" => $id1, "name" => $name1) = $data[0];
list("veryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryLongValue, "veryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryLongValue) = $data[0];
list("veryVeryVeryVeryVeryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryVeryVeryVeryVeryLongValue, "veryVeryVeryVeryVeryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryVeryVeryVeryVeryLongValue) = $data[0];

foreach ($data as list("id" => $id, "name" => $name)) {
    // logic here with $id and $name
}

foreach ($data as list("veryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryLongValue, "veryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryLongValue)) {
    // logic here with $id and $name
}

foreach ($data as list("veryVeryVeryVeryVeryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryVeryVeryVeryVeryLongValue, "veryVeryVeryVeryVeryVeryVeryVeryVeryLongKey" => $veryVeryVeryVeryVeryVeryVeryVeryVeryLongValue)) {
    // logic here with $id and $name
}

list(, $b) = ['a', 'b'];
list(, , $c) = ['a', 'b', 'c'];

while (list($id, $name, $salary) = $result->fetch(PDO::FETCH_NUM)) {
    echo " <tr>\n" .
        "  <td><a href=\"info.php?id=$id\">$name</a></td>\n" .
        "  <td>$salary</td>\n" .
        " </tr>\n";
}

list($a, list($b, $c)) = array(1, array(2, 3));

list($a[0], $a[1], $a[2]) = $info;

foreach ($data as ["id" => $id, "name" => $name]) {
    echo "id: $id, name: $name\n";
}

list(0 => $first, 1 => $second, 2 => $three, 3 => $fourth) = $arr;
list(
    0 => $first, 1 => $second, 2 => $three, 3 => $fourth
) = $arr;

list($first, $second, $three, $fourth) = $arr;
list(,$first, $second, $three, $fourth,) = $arr;
list(,,$first, $second, $three, $fourth,,) = $arr;
list(,,$first,, $second,, $three,, $fourth,,) = $arr;
list(,,,$first, $second, $three, $fourth,,,) = $arr;
list(,,,$first,,, $second,,, $three,,, $fourth,,,) = $arr;

list(0 => $firstVeryVeryVeryVeryLong, 1 => $secondVeryVeryVeryVeryLong, 2 => $threeVeryVeryVeryVeryLong, 3 => $fourthVeryVeryVeryVeryLong) = $arr;
list(,0 => $firstVeryVeryVeryVeryLong, 1 => $secondVeryVeryVeryVeryLong, 2 => $threeVeryVeryVeryVeryLong, 3 => $fourthVeryVeryVeryVeryLong,) = $arr;
list(,,0 => $firstVeryVeryVeryVeryLong, 1 => $secondVeryVeryVeryVeryLong, 2 => $threeVeryVeryVeryVeryLong, 3 => $fourthVeryVeryVeryVeryLong,,) = $arr;
list(,,0 => $firstVeryVeryVeryVeryLong,, 1 => $secondVeryVeryVeryVeryLong,, 2 => $threeVeryVeryVeryVeryLong,, 3 => $fourthVeryVeryVeryVeryLong,,) = $arr;
list(,,,0 => $firstVeryVeryVeryVeryLong, 1 => $secondVeryVeryVeryVeryLong, 2 => $threeVeryVeryVeryVeryLong, 3 => $fourthVeryVeryVeryVeryLong,,,) = $arr;
list(,,,0 => $firstVeryVeryVeryVeryLong,,, 1 => $secondVeryVeryVeryVeryLong,,, 2 => $threeVeryVeryVeryVeryLong,,, 3 => $fourthVeryVeryVeryVeryLong,,,) = $arr;

list(
    0 => $firstVeryVeryVeryVeryLong,

    1 => $secondVeryVeryVeryVeryLong,


    2 => $threeVeryVeryVeryVeryLong,



    3 => $fourthVeryVeryVeryVeryLong
) = $arr;

list("id" => $id1, "name" => $name1) = $data[0];
["id" => $id1, "name" => $name1] = $data[0];

foreach ($data as list("id" => $id, "name" => $name)) {
    // logic here with $id and $name
}

foreach ($data as ["id" => $id, "name" => $name]) {
    // logic here with $id and $name
}

function swap( &$a, &$b ): void
{ [ $a, $b ] = [ $b, $a ]; }

$array = [1, 2];
list($a, &$b) = $array;
[$a, &$b] = $array;
list(&$a, $b,, list(&$c, $d)) = $array;
[&$a, $b,, [&$c, $d]] = $array;

foreach ($array as list(&$a, $b)) {
}
foreach ($array as [&$a, $b]) {
}
