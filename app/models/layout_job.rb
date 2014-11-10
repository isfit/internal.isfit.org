require_dependency 'layout_jobs/publishings'
require_dependency 'layout_jobs/statuses'

class LayoutJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates_presence_of :description, :user_info, :work_title

  # Returner alle personene som er med i layout, i et format som kan gis
  # direkte til jEditable.
  def self.users_json
    layout_group_id = 98
    leader_id = 854

    User
      .joins(:groups)
      .where("groups.id = ?", layout_group_id)
      .map {|user| {user.id => user.full_name} unless user.id.eql? 1 }
      .compact
      .push({selected: leader_id.to_s})
      .reduce(&:merge)
      .to_json
      .to_s
  end

  def self.status_options_json
    self.status_options.map {|arr| { arr[1] => arr[0] }}.reduce(&:merge).to_json
  end

  def self.jobs_for_role roles, positions
    if roles.one? {|r| r.name.eql? 'layout'}
      self.where('status != 6').order(:updated_at)
    elsif roles.one? {|r| r.name.eql? 'admin'}
      self.order(:updated_at)
    else
      @group_ids = positions.last.groups.collect { |g| g.id }
      self.where("layout_jobs.group_id IN (?)", @group_ids)
    end
  end

  def owner
    if owner_id
      User.find(owner_id).full_name
    else
      "Ingen enda"
    end
  end

  def color
    colors = ["#dff0d8", "#d9edf7", "#fcf8e3", "#ddd", "#f2dede"]

    if owner_id
      colors.fetch(owner_id % 4)
    else
      "#f2dede"
    end
  end

  def publishing_name
    Internal::LayoutJobs::Publishings.name_for(self.publishing)
  end

  def self.publishing_options
    Internal::LayoutJobs::Publishings.publishing_options
  end

  def self.status_options
    Internal::LayoutJobs::Statuses.status_options
  end

  def status_name
    Internal::LayoutJobs::Statuses.name_for(self.status)
  end

  def status_color
    Internal::LayoutJobs::Statuses.color_for(self.status)
  end
end
