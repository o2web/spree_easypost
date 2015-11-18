module Spree
  module EasyPost
    class Engine < Rails::Engine
      require 'spree/core'
      isolate_namespace Spree
      engine_name 'spree_easypost'

      # use rspec for tests
      config.generators do |g|
        g.test_framework :rspec
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

      config.to_prepare &method(:activate).to_proc

      module ::EasyPost
        @@in_charge = nil

        def self.in_charge=(in_charge)
          @@in_charge = in_charge
        end

        def self.in_charge
          @@in_charge
        end
      end
    end
  end
end
