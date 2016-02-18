# EXTRACT 

class war {

    $api_war_name="graph.war"
    $api_directory="graph"
    $api_location="/usr/share/tomcat6/webapps"
    $restx_xml_conf="restx-conf.xml"
    $log4j_xml_conf="log4j.xml"
    $api_log="/var/log/dtac/graph"
    $jmx_jar_name="catalina-jmx-remote.jar"
    file { "$api_war_name":
        path => "$api_location/$api_war_name",
        source => "puppet:///modules/war/$api_war_name",
        ensure => present,
        owner => tomcat,
        group => tomcat,
    }

#restart command
#   exec { "restart_tomcat":
 #      command => "/etc/init.d/tomcat6 restart",
  #   require => File["$api_location/$api_war_name"],
   # }
#}

file { '/etc/init.d/tomcat':
  ensure => present,
  content => template('../../tomcat6/tomcat.erb'),
  mode   => 'u=rwx,og=rw',
  user   => 'root',
  group  => 'root',
  notify  => Exec['add_tomcat_service'],
}

exec {'add_tomcat_service':
  command   => '/sbin/chkconfig --add tomcat',
  path      => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
  onlyif    =>  "test `/sbin/chkconfig --list | /bin/grep tomcat | /usr/bin/wc -l` -eq 0",
  before    => Service['tomcat'],
}

service { 'tomcat':
  ensure  => started,
  hasstatus => true,
  hasrestart => true,
}
