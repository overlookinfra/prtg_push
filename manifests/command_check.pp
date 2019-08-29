define prtg_push::command_check (
  String[1] $command,
  String[1] $hostname,
  String[2] $port,
  String[1] $token,
  $cron_hour   = '*',
  $cron_minute = '*',
) {
  file {"/opt/prtg_push/command_${title}.sh":
    ensure   => present,
    mode     => '700',
    content  => epp('prtg_push/command_check.epp', {
                  command        => $command,
                  friendly_name  => $title,
                  hostname       => $hostname,
                  port           => $port,
                  token          => $token,
                }),
                
  }

  cron { "prtg_push_command_check_${title}":
    command  => "bash -x /opt/prtg_push/command_${title}.sh",
    user     => 'root',
    hour     => $cron_hour,
    minute   => $cron_minute,
  }
}
