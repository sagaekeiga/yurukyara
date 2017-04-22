worker_processes 2
working_directory "/home/anime/yurukyara/current"

listen "/var/run/unicorn/unicorn_yurukyara.sock"
pid "/var/run/unicorn/unicorn_yurukyara.pid"

preload_app true