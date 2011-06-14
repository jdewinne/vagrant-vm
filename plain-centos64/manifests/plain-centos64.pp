class utils::base {
  include repos::epel
  include repos::elff

  package { ['bash', 'wget', 'curl', 'patch']:
    ensure => present,
    require => [Package['epel-release'], Package['elff-release']],
  }
}

class utils::vcs {
  include repos::epel
  include repos::elff

  package { ['mercurial', 'git']:
    ensure => present,
    require => [Package['epel-release'], Package['elff-release']],
  }
}

class repos::epel {
  package { 'epel-release':
    provider => rpm,
    ensure => present,
    source => '/vagrant-share/repos/epel-release-5-4.noarch.rpm',
  }
}

class repos::elff {
  package { 'elff-release':
    provider => rpm,
    ensure => present,
    source => '/vagrant-share/repos/elff-release-5-3.noarch.rpm',
  }
}

class repos::jpackage {
  package { ['jpackage-utils', 'yum-priorities']:
    ensure => present,
  }

  package { 'jpackage-release':
    provider => rpm,
    ensure => present,
    source => '/vagrant-share/repos/jpackage-release-5-4.jpp5.noarch.rpm',
    require => [Package['jpackage-utils'], Package['yum-priorities']],
  }
}

include repos::jpackage
include utils::base
include utils::vcs

