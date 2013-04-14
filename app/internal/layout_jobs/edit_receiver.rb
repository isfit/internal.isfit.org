module Internal
  module LayoutJobs
    class EditReceiver
      def initialize id, value, type
        @layout_job = LayoutJob.find(id)
        set_value(type, value)
        @layout_job.save
      end

      def set_value(type, value)
        case type
        when 'status'
          @layout_job.status = value.to_i
          @result = LayoutJob.status_options[value.to_i - 1][0].to_s
        when 'owner'
          @layout_job.owner_id = value.to_i
          @result = User.find(value.to_i).full_name
        end
      end

      def result
        @result
      end
    end
  end
end
