class dmlite::plugins::domeadapter::config::disk (
  $dome_disk_url,
  $dome_head_url,
  $davix_ca_path      = $dmlite::plugins::domeadapter::params::davix_ca_path,
  $davix_cert_path    = $dmlite::plugins::domeadapter::params::davix_ca_cert_path,
  $davix_private_key_path = $dmlite::plugins::domeadapter::params::davix_private_key_path,
  $dome_head_url      = $dmlite::plugins::domeadapter::params::dome_head_url,
  $dome_disk_url      = $dmlite::plugins::domeadapter::params::dome_disk_url,
  $token_password,
  $token_id           = $dmlite::plugins::domeadapter::params::token_id,
  $token_life         = $dmlite::plugins::domeadapter::params::token_life,
  $adminuser          = undef,
) inherits dmlite::plugins::domeadapter::params {

  Class[dmlite::plugins::domeadapter::install] -> Class[dmlite::plugins::domeadapter::config::disk]


  dmlite::plugins::domeadapter::create_config{'head_config':
    config_dir_name    => 'dmlite',   # put file in /etc/dmlite.conf.d/domeadapter.conf
    dome_head_url      => $dome_head_url,
    dome_disk_url      => $dome_disk_url,
    davix_ca_path      => $davix_ca_path,
    davix_cert_path    => $davix_cert_path,
    davix_private_key_path => $davix_private_key_path,
    enable_io          => true,
    enable_ns          => true,
    enable_pooldriver  => true,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
    adminuser          => $adminuser,
  }

  dmlite::plugins::domeadapter::create_config{'disk_config_http':
    config_dir_name    => 'dmlite-disk',   # put file in /etc/dmlite-disk.conf.d/domedaapter.conf
    dome_head_url      => $dome_head_url,
    dome_disk_url      => $dome_disk_url,
    davix_ca_path      => $davix_ca_path,
    davix_cert_path    => $davix_cert_path,
    davix_private_key_path => $davix_private_key_path,
    enable_io          => true,
    enable_ns          => true,
    enable_pooldriver  => true,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
    adminuser          => $adminuser,
  }
}

