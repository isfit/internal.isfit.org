require 'spec_helper'

describe LayoutJobsController do
  describe "GET index" do
    before :each do
      LayoutJob.delete_all
      @user = User.create! password: 'whatever'
      @controller.stub(:current_user) { @user }

      @deleted_status = 6
      
      @position = Position.create!
      @user.stub(:positions) { [@position] }
      @group = Group.create! tag: 'lol'
      @position.stub(:groups) { [@group] }

      users_job = LayoutJob.create! owner_id: @user.id, description: 'whatever', user_info: 'whatever', work_title: 'lol', status: 1, group_id: @group.id
      not_users_job = LayoutJob.create! owner_id: @user.id + 2, description: 'whatever', user_info: 'whatever', work_title: 'lol', status: 1
      deleted_job = LayoutJob.create! owner_id: @user.id + 2, description: 'whatever', user_info: 'what_ever', work_title: 'lol', status: @deleted_status
      @jobs = [users_job, not_users_job, deleted_job]
    end

    it "should give all jobs back to admins" do
      @user.stub(:roles) { [Role.create!(name: 'admin')] }
      get :index
      assigns(:layout_jobs).should eq(@jobs)
    end

    it "should give all jobs not deleted to a layout member" do
      @user.stub(:roles) { [Role.create!(name: 'layout')] }
      get :index
      assigns(:layout_jobs).should eq(@jobs.delete_if {|j| j.status.eql? @deleted_status })
    end

    it "should give a normal user his own jobs" do
      get :index
      assigns(:layout_jobs).should eq(@jobs.delete_if {|j| j.owner_id != @user.id })
    end
  end
end