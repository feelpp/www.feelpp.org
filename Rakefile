autoload :FileUtils, 'fileutils'

desc 'Execute the middleman build command'
task :build do
  run 'middleman build --no-clean -e production'
end

namespace :deploy do
  desc 'Deploy to GitHub Pages from a GitHub CI build'
  task :github do
    Rake::Task['build'].invoke
    FileUtils.cp_r 'config/meta/.', 'public'
  end
end

def run command, opts = {}
  system command
  unless $?.exitstatus.zero? || opts[:ignore_failure]
    raise %(Previous command exited with unexpected status code #{$?.exitstatus})
  end
end
