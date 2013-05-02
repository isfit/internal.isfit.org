module LayoutJobsHelper
  def google_date(date_string)
    if date_string.nil?
      Time.now.to_s[0..9].gsub('-', '')
    else
      date_string.to_s.gsub('-', '')
    end
  end
end
