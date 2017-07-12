# Cookbook Name:: refresh_tomcat
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

#
# Variables
#
$node_name = Chef.run_context.node.name
$run = false
$upload = false
$restart = false

#
# Main process
#
include_recipe 'refresh_tomcat::run_jar'

include_recipe 'refresh_tomcat::upload_file'

include_recipe 'refresh_tomcat::tomcat'

ruby_block 'Send Email jar' do
  block do
    message = 'chef-client performed the following tasks:'
    message << "\n\- Run logFinderv2.jar" if $run
    message << "\n\- Upload logFinder.log" if $upload
    message << "\n\- Restart Tomcat" if $restart
    Chef::Log.info(message)
    Tools.simple_email 'cbeleno@redsis.com', :message => message, :subject => "Chef Run jar on Node #{$node_name}"
  end
end
