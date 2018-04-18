class prtg_push {
  file {'/opt/prtg_push':
    ensure  => directory,
    purge   => true,
  }
}
