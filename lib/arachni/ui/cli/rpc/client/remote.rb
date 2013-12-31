=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    All rights reserved.
=end

require_relative 'remote/option_parser'
require_relative 'instance'

module Arachni

require Options.paths.lib + 'rpc/client/dispatcher'
require Options.paths.lib + 'rpc/client/instance'
require Options.paths.lib + 'utilities'
require Options.paths.lib + 'ui/cli/utilities'

module UI::CLI
module RPC::Client

# Provides a command-line RPC client and uses a {RPC::Server::Dispatcher} to
# provide an {RPC::Server::Instance} in order to perform a scan.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
class Remote
    include Arachni::UI::Output

    def initialize
        parser = Remote::OptionParser.new
        parser.authorized_by
        parser.scope
        parser.audit
        parser.http
        parser.checks
        parser.reports
        parser.plugins
        parser.platforms
        parser.session
        parser.profiles
        parser.distribution
        parser.ssl
        parser.parse

        options = parser.options

        begin
            dispatcher = Arachni::RPC::Client::Dispatcher.new( options, options.dispatcher.url )

            # Get a new instance and assign the url we're going to audit as the 'owner'.
            instance_info = dispatcher.dispatch( options.url )
        rescue Arachni::RPC::Exceptions::ConnectionError => e
            print_error "Could not connect to Dispatcher at '#{options.dispatcher.url}'."
            print_debug "Error: #{e.to_s}."
            print_debug_backtrace e
            exit 1
        end

        instance = nil
        begin
            instance = Arachni::RPC::Client::Instance.new( options,
                                                            instance_info['url'],
                                                            instance_info['token'] )
        rescue Arachni::RPC::Exceptions::ConnectionError => e
            print_error 'Could not connect to Instance.'
            print_debug "Error: #{e.to_s}."
            print_debug_backtrace e
            exit 1
        end

        # Let the Instance UI manage the Instance from now on.
        Instance.new( Arachni::Options.instance, instance ).run
    end

end

end
end
end
