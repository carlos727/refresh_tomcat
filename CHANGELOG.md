# CHANGELOG

#### Changelog v1.0.2 13/02/2017:

- Resource `powershell_script 'Run jar'` was added in `run_jar.br` recipe to run `logFinderv2.jar`.

- Resource `ruby_block 'Run jar'` was modified in `run_jar.br` recipe, now verify the jar's execution.

#### Changelog v1.0.1 12/02/2017:

- Resources `directory 'C:\chef\AzureUploader'` and `windows_zipfile 'C:\chef\AzureUploader'` were added to download AzureUploader.

#### Changelog v1.0.0 10/02/2017:

- Cookbook modular with the Ruby Style Guide rules.

- Recipe `run_jar.rb` has the code to run `logFinderv2.jar`.

- Recipe `upload_file.rb` has the code to upload `logFinder.log` to Azure.

- Recipe `tomcat.rb` has the code to manage the service `Tomcat7`.
