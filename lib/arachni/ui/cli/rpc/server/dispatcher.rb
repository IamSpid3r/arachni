=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    All rights reserved.
=end

require 'terminal-table/import'
require_relative 'dispatcher/option_parser'

module Arachni

require Options.paths.lib + 'rpc/server/dispatcher'
require Options.paths.lib + 'ui/cli/utilities'

module UI::CLI
module RPC
module Server

# @author Tasos "Zapotek" Laskos<tasos.laskos@gmail.com>
class Dispatcher

    def initialize
        OptionParser.new.parse

        ::EM.run do
            Arachni::RPC::Server::Dispatcher.new
        end
    end

end
end
end
end
end
