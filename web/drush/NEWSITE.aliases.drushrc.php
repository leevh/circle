<?php

// local alias

$local_sites = '/var/www/web/';

$aliases['dev'] = array(
    'root' => $local_sites,
    'path-aliases' => array('%dump-dir' => $local_sites . 'drush.dbdumps', '%files' => $local_sites . 'sites/default/files'));

// Remote Test alias

$aliases['live'] = array(
    'uri' => 'live.NEWSITE.leevdesigns.com',
    'root' => '/data/disk/host/static/live-NEWSITE/web',
    'remote-user' => 'host.ftp',
    'remote-host' => 'host.server.leevdesigns.com',

    // No need to modify the following settings
    'command-specific' => array(
        'sql-sync' => array(
            'sanitize' => TRUE,
            'no-ordered-dump' => TRUE,
            'structure-tables' => array(
                // You can add more tables which contain data to be ignored by the database dump
                'common' => array('cache', 'cache_filter', 'cache_menu', 'cache_page', 'history', 'sessions', 'watchdog'),
            ),
        ),
    ),
);