site :opscode

metadata

group :integration do
  cookbook "apt"
end

group :test do
  cookbook 'java'
  cookbook 'tomcat_test', path: 'test/fixtures/tomcat_test'
end
