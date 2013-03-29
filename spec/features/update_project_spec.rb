require 'spec_helper'

describe "changing a project" do

  before do
    user = login_a_user
    @project = create_project_for(user)
  end

  it "updates a project" do
    visit "/projects/#{@project.id}/edit"
    select '4 weeks', :from => 'Iteration length'
    click_button 'Set iteration length'
    page.should have_content 'Project settings saved'
  end

  it "fails to update a project" do
    visit "/projects/#{@project.id}/edit"
    select '', :from => 'Iteration length'
    click_button 'Set iteration length'
    page.should have_content "Project settings couldn't be saved"
  end
end
