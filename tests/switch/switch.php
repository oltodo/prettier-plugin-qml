<?php
switch (2) {
  case 1:
    $test = 'first';
    break;
  case 2:
    $test = 'second';
    break;
  case 10:
  case 20:
    $test = 'big';
    break;
  case 100:
  default:
    $test = 1;
}

switch ($var):
  case 1:
  case 2:
    echo "Goodbye!";
    break;
  default:
    echo "I only understand 1 and 2.";
endswitch;

switch ( 2 ) {
    case 1:
        $test = 'first';
        break;
    default:
        $test = 1;
}
switch ($i):
    case 0:
        echo "i equals 0";
        break;
    case 1:
        echo "i equals 1";
        break;
    case 2:
        echo "i equals 2";
        break;
    case 3:
    default:
        echo "i is not equal to 0, 1 or 2";
endswitch;

switch ($expr) {
    case 0:
        echo 'First case, with a break';
        break;
    case 1:
        echo 'Second case, which falls through';
        // no break
    case 2:
    case 3:
    case 4:
        echo 'Third case, return instead of break';
        return;
    default:
        echo 'Default case';
        break;
}

switch ($longLongLongLongLongLongLongLongLongLongLongLongLongLongLongLongVariable) {}

switch ($longLongLongLongLongLongLongVariable && $longLongLongLongLongLongLongVariable) {}

switch (1) {
    case $exception->veryVeryVeryVeryVeryVeryVeryVeryVeryLongMethod()->veryVeryVeryVeryVeryVeryVeryLongProperty:
        break;
}
