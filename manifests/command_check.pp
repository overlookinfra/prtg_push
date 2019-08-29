# @summary
#   This type creates a cron job to run a shell script that executes an arbitrary command.
#
# @param cron_hour 
#   The hour to run the cron job.
#
# @param cron_minute
#   The minute to run the cron job.
#
# @param command
#   Specifies the command to run on the *nix machine.
#
# @param hostname
#   Configures the hostname of the PRTG server.
#
# @param port
#   The network port number of the PRTG HTTP push sensor.
#
# @param token
#   Specifies the PRTG identification token to use for this sensor.
#
define prtg_push::command_check (
  $cron_hour    = '*',
  $cron_minute  = '*',
  $command,
  $hostname,
  $port,
  $token,
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
