# @summary
#   Creates a cron job to execute a shell script to check for the latest file of a given 
#   type in a given directory, then pushes that information to PRTG.
#
# @param cron_hour 
#   The hour to run the cron job.
#
# @param cron_minute
#   The minute to run the cron job.
#
# @param file_ext
#   Specifies the file extension to check.
#
# @param check_dir
#   The directory to check.
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
define prtg_push::newest_file (
  $cron_hour    = '*',
  $cron_minute  = '*',
  $file_ext = '*.*',
  $check_dir,
  $hostname,
  $port,
  $token,
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
