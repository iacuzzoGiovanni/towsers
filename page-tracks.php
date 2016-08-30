<?php
$type = 'music';
$args=array(
  'post_type' => $type,
  'post_status' => 'publish',
  'posts_per_page' => -1);

$data = [];   
$my_query = new WP_Query($args);
if( $my_query->have_posts() ) {
  while ($my_query->have_posts()) : $my_query->the_post();
    $tmp = [get_field('music_url')];
    array_push($data, $tmp);
  endwhile;
}    
echo json_encode($data);