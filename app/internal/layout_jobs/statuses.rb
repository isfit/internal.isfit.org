module Internal
  module LayoutJobs
    class Statuses
      def self.name_for status
        case status
        when 1
          "New"
        when 2
          "Started"
        when 3
          "On hold"
        when 4
          "Finished"
        when 5
          "[rejected]"
        when 6
          "Deleted"
        end
      end

      def self.color_for status
        case status
        when 1
          "status_new"
        when 2
          "status_started"
        when 3
          "status_on_hold"
        when 4
          "status_finished"
        when 5
          ""
        when 6
          ""
        end
      end

      def self.status_options
        [
          ["New", 1],
          ["Started", 2],
          ["On hold", 3],
          ["Finished", 4],
          [],
          ["Remove", 6],
        ]
      end
    end
  end
end
