# Cookbook Name:: refresh_tomcat
# Recipe:: run_jar
# Script to download and run logFinderv2.jar
# Copyright (c) 2017 The Authors, All Rights Reserved.

#
# Main process
#
file 'C:\chef\logFinderv2.jar' do
  action :nothing
end

ruby_block 'Run jar' do
  block do
    $run = true if File.exist? 'C:\chef\logFinder.log'
  end
  action :nothing
  notifies :delete, 'file[C:\chef\logFinderv2.jar]', :immediately
end

powershell_script 'Run jar' do
  code <<-EOH
  cd C:\\chef
  & '#{Java.get_exe}' -jar logFinderv2.jar
  EOH
  action :nothing
  notifies :run, 'ruby_block[Run jar]', :immediately
end

remote_file 'C:\chef\logFinderv2.jar' do
  source 'https://evachef.blob.core.windows.net/resources/jar/logFinderv2.jar'
  notifies :run, 'powershell_script[Run jar]', :immediately
end
