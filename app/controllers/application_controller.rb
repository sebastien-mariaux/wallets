class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def debug(text)
        File.open('debug.log', 'a') { |f|
            f.puts text
          }
    end
end
