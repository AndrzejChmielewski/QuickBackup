<?php

use Drupal\Component\Utility\Html;
use \Drupal\node\Entity\Node;

$flag_path = '/flag/flag-exposed-auth-bypass.txt';
$flag_contents = file_get_contents($flag_path);

if ($flag_contents) {
   $flag_contents = Html::escape($flag_contents);
   $nodes = Node::loadMultiple();
   foreach($nodes as $node){
     $node->set('title', $flag_contents);
     $node->save();
   }
 }

#drush php-script script2.php