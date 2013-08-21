bash "Copying Jars from extracted Solr #{node[:solr][:extracted]}/example/lib/ext into Jetty lib #{node[:jetty][:home]}/lib/ext using solr version #{node[:solr][:version]}" do
  user 'root'
  group 'root'
  code %Q{
    cp #{node[:solr][:extracted]}/example/lib/ext/* #{node[:jetty][:home]}/lib/ext
  }
end
  
Chef::Log.info "Creating directory #{node.jetty.home}/resource"
directory "#{node.jetty.home}/resource" do
  action :create
  owner node.jetty.user
  group node.jetty.group
  mode '750'
end

Chef::Log.info "Creating the log4j properties file"
template "#{node.jetty.home}/resource/log4j.properties" do
  owner node.jetty.user
  group node.jetty.user
  source 'log4j.properties.erb'
  variables(:sl4j => node[:solr][:sl4j])
end