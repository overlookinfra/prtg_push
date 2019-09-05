# @summary
#   Creates a cron job to execute a shell script to check if an arbitrary service is running,
#   then pushes that information to PRTG.
#
# @param cron_hour 
#   The hour to run the cron job.
#
# @param cron_minute
#   The minute to run the cron job.
#
# @param service_name
#   Specifies the name of the service to check.
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
define prtg_push::service_check (
  $cron_hour    = '*',
  $cron_minute  = '*',
  $service_name = $title,
  $hostname,
  $port,
  $token,
) {
  file { "/opt/prtg_push/service_${title}.sh":
    ensure  => present,
    mode    => '0700',
    content => epp('prtg_push/service_check.epp', {
                  service_name  => $service_name,
                  friendly_name => $title,
                  hostname      => $hostname,
                  port          => $port,
                  token         => $token,
                }),

  }

  cron { "prtg_push_service_check_${title}":
    command => "bash -x /opt/prtg_push/service_${title}.sh",
    user    => 'root',
    hour    => $cron_hour,
    minute  => $cron_minute,
  }
}
