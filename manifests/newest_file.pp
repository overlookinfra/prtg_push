define prtg_push::newest_file (
  String[1] $check_dir,
  String[1] $hostname,
  String[2] $port,
  String[1] $token,
  $cron_hour       = '*',
  $cron_minute     = '*',
  String $file_ext = '*.*',
) {
  file {"/opt/prtg_push/newest_file_${title}.sh":
    ensure   => present,
    mode     => '700',
    content  => epp('prtg_push/newest_file.epp', {
                  file_ext   	 => $file_ext,
                  check_dir      => $check_dir,
                  hostname       => $hostname,
                  port           => $port,
                  token          => $token,
                }),
                
  }

  cron { "prtg_push_newest_file_${title}":
    command  => "bash -x /opt/prtg_push/newest_file_${title}.sh",
    user     => 'root',
    hour     => $cron_hour,
    minute   => $cron_minute,
  }
}
