=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    All rights reserved.
=end

require_relative '../../../framework/option_parser'

module Arachni
module UI::CLI
module RPC
module Client
class Local

# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
class OptionParser < UI::CLI::Framework::OptionParser

    def distribution
        separator 'Distribution'

        on( '--instance-spawns SPAWNS', Integer,
            'How many slaves to spawn for a high-performance mult-Instance scan.'
        ) do |spawns|
            options.spawns = spawns
        end
    end

end
end
end
end
end
end
