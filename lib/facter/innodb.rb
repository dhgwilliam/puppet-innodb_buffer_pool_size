Facter.add(:innodb_buffer_pool_size) do
  confine :kernel => "Linux"
  setcode do
    mysql_bin = Facter::Util::Resolution.exec('which mysql 2> /dev/null') || nil
    if mysql_bin
      dbuser = Facter::Util::Resolution.exec('puppet master --configprint dbuser')
      dbpassword = Facter::Util::Resolution.exec('puppet master --configprint dbpassword')
      dbserver = Facter::Util::Resolution.exec('puppet master --configprint dbserver')
      Facter::Util::Resolution.exec("mysql -rs -h#{dbserver} -u#{dbuser} -p#{dbpassword} -e \'SELECT @@innodb_buffer_pool_size;\' 2> /dev/null| tail -n1")
    end
  end
end
