# Cookbook Name:: refresh_tomcat
# Recipe:: tomcat
# Script to restart Tomcat and wait for this to continue
# Copyright (c) 2017 The Authors, All Rights Reserved.

#
# Main process
#
ruby_block 'Wait Tomcat' do
  block do
    Tomcat.wait_start
    $restart = true
  end
  action :nothing
end

windows_service 'Tomcat7' do
  timeout 180
  action :restart
  notifies :run, 'ruby_block[Wait Tomcat]', :immediately
end
