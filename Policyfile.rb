name 'haproxy'
run_list 'haproxy::default'
default_source :community
cookbook 'haproxy', path: '.'
