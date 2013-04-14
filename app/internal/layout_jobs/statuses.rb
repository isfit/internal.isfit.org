module Internal
  module LayoutJobs
    class Statuses
      def self.name_for status
        case status
        when 1
          "New"
        when 2
          "Open"
        when 3
          "On hold"
        when 4
          "Resolved"
        when 5
          "Rejected"
        when 6
          "Deleted"
        end
      end

      def self.color_for status
        case status
        when 1
          "status_new"
        when 2
          "status_open"
        when 3
          "status_on_hold"
        when 4
          "status_resolved"
        when 5
          "status_rejected"
        when 6
          "status_deleted"
        end
      end

      def self.status_options
        [
          ["New", 1],
          ["Open", 2],
          ["On hold", 3],
          ["Resolved", 4],
          ["Rejected", 5],
          ["Deleted", 6]
        ]
      end
    end
  end
end
