require 'spec_helper'

describe "Static Pages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Schöne Ostern")
        FactoryGirl.create(:micropost, user: user, content: "Frohe Ostern")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

#      it "should render other user's feed without delete link" do
#        user.feed.each do |item|
#          expect(page).to have_selector("li##{item.id}", text: item.content)
#        end
#      end

      describe "show correct number of microposts (plural)" do
        it { should have_content(user.microposts.count.to_s() + " micropost") }
      end

## Commented out due to the gizillion warning messages
#      describe "microposts pagination" do
#        before(:all) do 
##           user = FactoryGirl.create(:user)
#           30.times {
#           FactoryGirl.create(:micropost, user: user, content: "Alles Gute") } 
#        end
#        after(:all) { Micropost.delete_all }
#        it { should have_selector('div.pagination') }
#
#      end

    end

    describe "show correct number of microposts (singular)" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Prost Neujahr")
        sign_in user
        visit root_path
      end
      it { should have_content(user.microposts.count) }
      it { should_not have_content("microposts") }
    end

  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like 'all static pages'
  end

  describe "Contact" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "my rails tour"
    expect(page).to have_title(full_title(''))
  end

end
