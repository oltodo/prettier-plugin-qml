<?php
eval('return 1;');
eval("return $a;");
eval("$veryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongVariableName = $veryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongVariableValue;");
eval("VeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongText" . "VeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongText" . "VeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongText");
eval('string
string
string');
eval(
    'string
string
string'
);
eval("string
string
string
$var");
eval(
    "string
string
string
$var"
);
eval(`string
string
string
$var`);
eval(
`string
string
string
$var`
);
eval(<<<FOO
string
string
string
$var
FOO
);
eval(<<<'FOO'
string
string
string
FOO
);

$obj = eval('return new class($value)
{
    private $foo;

    public function __construct($foo)
    {
        $this->foo = $foo;
    }

    /**
     * @return mixed
     */
    public function getFoo()
    {
        return $this->foo;
    }

    /**
     * @param mixed $foo
     */
    public function setFoo($foo)
    {
        $this->foo = $foo;
    }
};');
