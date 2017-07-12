# Cookbook Name:: refresh_tomcat
# Recipe:: upload_file
# Script to download AzureUploader application and upload logFinder.log file to Azure
# Copyright (c) 2017 The Authors, All Rights Reserved.

#
# Variables
#
azure_command = <<-SCRIPT
cd C:\\chef\\AzureUploader
.\\AzureUploader.exe
SCRIPT

#
# Main process
#
file 'C:\chef\logFinder.log' do
  action :nothing
end

directory 'C:\chef\AzureUploader' do
  recursive true
  action :delete
  only_if { File.directory?('C:\chef\AzureUploader') }
end

windows_zipfile 'C:\chef\AzureUploader' do
  source 'https://evachef.blob.core.windows.net/resources/installer/AzureUploader.zip'
  action :unzip
end

template 'C:\chef\AzureUploader\settings.config' do
  source 'settings.erb'
  variables :node_name => $node_name
  only_if { $run }
end

ruby_block 'AzureUploader (PowerShell)' do
  block do
    upload = powershell_out!(azure_command)
    Chef::Log.info("\n#{upload.stdout.chop}")
    $upload = true
  end
  only_if { $run }
end

ruby_block 'Delete .zip File Chef' do
  block do
    Dir.foreach('C:\chef') do |zipFile|
      next if !zipFile.start_with? $node_name
      File.delete "C:\\chef\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  notifies :delete, 'file[C:\chef\logFinder.log]', :immediately
end
