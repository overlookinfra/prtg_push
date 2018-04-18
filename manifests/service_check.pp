define prtg_push::service_check (
  $cron_hour    = '*',
  $cron_minute  = '*',
  $service_name = "${title}",
  $hostname,
  $port,
  $token,
) {
  file {"/opt/prtg_push/service_${title}.sh":
    ensure   => present,
    mode     => '700',
    content  => epp('prtg_push/service_check.epp', {
                  service_name   => $service_name,
                  friendly_name  => $title,
                  hostname       => $hostname,
                  port           => $port,
                  token          => $token,
                }),
                
  }

  cron { "prtg_push_service_check_${title}":
    command  => "bash -x /opt/prtg_push/service_${title}.sh",
    user     => 'root',
    hour     => $cron_hour,
    minute   => $cron_minute,
  }
}
