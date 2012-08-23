Facter.add(:innodb_buffer_pool_size) do
  confine :kernel => "Linux"
  setcode do
    dbuser = Facter::Util::Resolution.exec('puppet master --configprint dbuser')
    dbpassword = Facter::Util::Resolution.exec('puppet master --configprint dbpassword')
    Facter::Util::Resolution.exec("mysql -rs -u#{dbuser} -p#{dbpassword} -e \'SELECT @@innodb_buffer_pool_size;\' | tail -n1")
  end
end
