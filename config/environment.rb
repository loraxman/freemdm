# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

$CLASSPATH << ENV['ORACLE_JDBC_JAR']
$CLASSPATH << ENV['MYSQL_JAR']