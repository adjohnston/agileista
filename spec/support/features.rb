module FeatureHelpers
  def login_a_user
    person = Person.make!
    person.confirm!
    login_as(person, :scope => :person)
    person
  end

  def create_project_for(person, is_scrum_master = true)
    project = Project.make!
    person.projects << project
    project.scrum_master = person if is_scrum_master
    project.save!
    project
  end

  def create_sprint_for(project)
    Sprint.make!(:project => project)
  end

  def create_user_story_for(project)
    UserStory.make!(:project => project)
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers, :type => :feature
  config.include FeatureHelpers, :type => :feature
  Warden.test_mode!
  config.after(:each, :type => :feature) do
    Warden.test_reset!
  end
end
