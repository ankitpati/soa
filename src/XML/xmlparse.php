#!/usr/bin/env php
<?php

sizeof($argv) === 2 or die("Usage:\n\txmlparse.php <filename>\n");

($users = @simplexml_load_file($argv[1])) !== false
    or die("$argv[1] cannot be opened.\n");

print_r($users);
