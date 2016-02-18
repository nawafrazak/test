# Tomcat module

class tomcat6 {

    $tomcat = "tomcat6"

    package { "$tomcat": 
        ensure => latest,
   }
   # a fuller example, including permissions and ownership
 #  file { '/usr/share/$tomcat/conf':
  #  ensure => 'directory',
   # owner  => 'tomcat',
   # group  => 'tomcat',
   # mode   => '0755',
   # }

    file { "tomcat_conf":
	    path => "/usr/share/$tomcat/conf/$tomcat.conf",
    	content => template("$tomcat/conf/$tomcat.conf.erb"),
        require => Package["$tomcat"],
    }

}
