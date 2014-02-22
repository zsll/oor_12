require "resque/tasks"

task "resque:setup" => :environment do
 Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection } #http://stackoverflow.com/questions/10170807/activerecordstatementinvalid-pg-error
end