class rabbitmq::repo::rhel (
    $key = "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc",
    $version = "2.8.4",
    $relversion = "1"
) { 
    exec { "rpm --import ${key}":
        path => ["/bin","/usr/bin","/sbin","/usr/sbin"],
        retries => 3,
        sleep   => 15,
    }

    package { "rabbitmq-server":
        provider => rpm,
        ensure => installed,
        source => "http://www.rabbitmq.com/releases/rabbitmq-server/v${version}/rabbitmq-server-${version}-${relversion}.noarch.rpm",
        require => Exec["rpm --import ${key}"],
    }

}

