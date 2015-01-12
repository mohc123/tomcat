require_relative '../../../kitchen/data/spec_helper'

%w(webapps conf logs work).each do |folder|
  %w(dam pentaho).each do |app|
    describe file("/ca/web/#{app}/#{folder}") do
      it { should be_directory }
      it { should be_owned_by 'tomcat' }
    end
  end
end

describe file('/usr/sbin/tomcat') do
  it { should contain(':').from(/^if \[ -r \"\$TOMCAT_CFG\" \]; then/).to(/end/) }
  it { should contain(':').from(/^if \[ -z \"\${TOMCAT_CFG}\" \]; then/).to(/end/) }
end

describe service('tomcat-dam') do
 it { should be_enabled }
 it { should be_running }
end

describe service('tomcat-pentaho') do
  it { should be_enabled }
  it { should be_running }
end

%w{8081 8083}.each do |port|
  describe command("curl http://localhost:#{port}/sample/") do
    its(:stdout) { should match /Sample \"Hello, World\" Application/ }
  end
end
