module Internal
  module LayoutJobs
    class Publishings
      def self.name_for publishing
        case publishing
        when 1
          "Web"
        when 2
          "Print"
        when 3
          "Both"
        when 4
          "Other"
        end
      end

      def self.publishing_options
        [
          ["Web", 1],
          ["Print", 2],
          ["Both", 3],
          ["Other", 4]
        ]
      end
    end
  end
end
