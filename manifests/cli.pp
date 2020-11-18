# @summary Manage Globus CLI
#
# @example
#   include ::globus::cli
#
# @param ensure
#   The ensure parameter for PIP installed CLI
# @param install_path
#   Path to install Globus CLI virtualenv
# @param manage_python
#   Boolean to set if Python is managed by this class
class globus::cli (
  String[1] $ensure = 'present',
  Stdlib::Absolutepath $install_path = '/opt/globus-cli',
  Boolean $manage_python = true,
) {

  $releasever = $facts['os']['release']['major']
  if versioncmp($releasever, '6') <= 0 {
    fail("${module_name}: CLI is not supported on OS major release ${releasever}")
  }

  if $manage_python {
    class { 'python':
      virtualenv => 'present',
    }
    Package['virtualenv'] -> Python::Virtualenv['globus-cli']
  }

  python::virtualenv { 'globus-cli':
    ensure     => 'present',
    venv_dir   => $install_path,
    distribute => false,
  }
  -> python::pip { 'globus-cli':
    ensure     => $ensure,
    virtualenv => $install_path,
  }

  file { '/usr/bin/globus':
    ensure  => 'link',
    target  => "${install_path}/bin/globus",
    require => Python::Pip['globus-cli'],
  }

}
