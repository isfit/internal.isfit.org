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
        when 'description'
          @layout_job.description = value
          @result = value
        when 'proofread'
          if valid_date? value
            @layout_job.last_proofread = value
            @result = value
          else
            @result = 'Invalid date'
          end
        when 'number'
          if valid_number? value
            @layout_job.number = value.to_i
            @result = value
          else
            @result = 'Invalid number'
          end
        end
      end

      def result
        @result
      end

      private
      def valid_date? date_string
        Date.parse date_string
        true
      rescue
        false
      end

      def valid_number? number_string
        number = number_string.to_i
        number > 0 && number < 101
      end
    end
  end
end
