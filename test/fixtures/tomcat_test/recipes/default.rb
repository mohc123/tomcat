include_recipe 'tomcat'

%w(dam pentaho).each do |webapp|

  remote_file "/ca/web/#{webapp}/webapps/sample.war" do
    source 'https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war'
    owner 'tomcat'
    group 'tomcat'
    checksum '570f196c4a1025a717269d16d11d6f37'
    notifies :restart, "service[tomcat#{node['tomcat']['suffix']}-#{webapp}]"
  end

  service "tomcat#{node['tomcat']['suffix']}-#{webapp}" do
    action :start
    supports ({ :restart => true, :reload => true, :status => true })
  end

end
