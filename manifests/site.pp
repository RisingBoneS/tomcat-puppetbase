class { 'java' :
 package       => 'java-1.8.0-openjdk-devel',
}
tomcat::install { '/opt/tomcat':
 source_url    => 'https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.0.M1/bin/apache-tomcat-9.0.0.M1.tar.gz',
}
tomcat::instance { 'default':
 catalina_home => '/opt/tomcat',
}
exec { 'retrieve_jenkins':
  command => "/usr/bin/wget -q http://mirrors.jenkins-ci.org/war/latest/jenkins.war -O /opt/tomcat/webapps/jenkins.war",
  creates => "/opt/tomcat/webapps/jenkins",
}
tomcat::war  { 'jenkins.war':
 catalina_base => '/opt/tomcat',
 war_source    => '/opt/tomcat/webapps/jenkins.war',
}
tomcat::config::server::tomcat_users { 'tomcat-user-manager':
 ensure        =>  present,
 catalina_base => '/opt/tomcat',
 element       => 'user',
 element_name  => 'manager',
 password      => 'verys3cr3t',
 roles         => ['manager-gui,manager-status,manager-jmx,manager-script'],
}
