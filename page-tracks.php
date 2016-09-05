<?php

function getMusicInfo()
{
    $type = 'music';
    $args=array(
      'post_type' => $type,
      'post_status' => 'publish',
      'posts_per_page' => -1);
    $data = [];   
    
    $my_query = new WP_Query($args);
    if( $my_query->have_posts() ) {
      while ($my_query->have_posts()) : $my_query->the_post();
        $tmp = ['url' => get_field('music_url'),
                'artist' => get_field('artist(s)'),
                'title' => get_field('title'),
                'cover' => get_field('cover')];
        array_push($data, $tmp);
      endwhile;
    }    
    
    echo json_encode($data);
}
getMusicInfo();