<?php
echo "test echo";
echo $test, $other;

$info = array('coffee', 'brown', 'caffeine');
list($drink, $color, $power) = $info;
list($reallyReallyReallyReallyLongName, $otherReallyReallyReallyLongName, $lastOne) = $info;

print "test print";
print("parens test");

isset($test);

unset($test);

empty($test);

isset($test, $test, $test,$test, $test, $test, $test, $test, $test, $test, $test, $test);

isset($test['foo']);
isset($a['cake']['a']['b']);
isset($expected_array_got_string['some_key']);
isset($expected_array_got_string[0]);
isset($expected_array_got_string['0']);
isset($expected_array_got_string[0.5]);
isset($expected_array_got_string['0.5']);
isset($expected_array_got_string['0 Mostel']);
