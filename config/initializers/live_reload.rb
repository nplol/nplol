#module Utils
  #module_function

  #def log (str)
    #::Rails.logger.debug "Brunch: #{str}"
  #end

  #def do_system (cmd)
    #Utils.log "Starting #{cmd}"
    #system cmd
    #Utils.log "#{cmd} exited with #{$?.exitstatus} status"
    #exit $?.exitstatus unless $?.exitstatus == 0
  #end

  #def background (name, &blk)
    #pid = fork(&blk)

    #at_exit do
      #Utils.log "Terminating #{name} [#{pid}]"
      #begin
        #Process.kill 'TERM', pid
        #Process.wait pid
      #rescue Errno::ESRCH, Errno::ECHILD => e
        #Utils.log "#{name} [#{pid}] already dead (#{e.class})"
      #end
    #end
  #end

#end

#module Nplol
  #class Application < Rails::Application
    #config.before_initialize do
      #cmd = 'brunch watch'

      #Utils.log "LETS DO THIS"

      #Utils.background(cmd) { Utils.do_system cmd }
    #end
  #end
#end
