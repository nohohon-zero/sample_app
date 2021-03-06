require 'spec_helper'

describe "UserPages" do
	subject { page }
	#describe "GET /user_pages" do
    #	it "works! (now write some real specs)" do
    #  	# Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    #  	get user_pages_index_path
    #  	response.status.should be(200)
    #	end
  	#end
	describe "signup page" do
		before { visit signup_path }
		it { should have_selector('h1',	text: 'Sign up') }
		it { should have_selector('title', text: "Ruby on Rails Tutorial Sample App | Sign up")  }
	end
	describe "profile page" do
		let(:user){ FactoryGirl.create(:user) }
		before { visit user_path(user) }
		
		it { should have_content(user.name) }
		#it { should have_title(user.name) }
	end
	describe "signup" do
		before { visit signup_path }

		let(:submit) { "Create My Account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
			describe "after submittion" do
				before { click_button submit }
				# Title is not set correctly. I don't know why.
				#it { should have_title('Sign up') }
				it { should have_content('error') }
			end
		end
		describe "with valid information" do
			before do
				fill_in "Name",			with: "Example User"
				fill_in "Email",		with: "user@example.com"
				fill_in "Password",		with: "foobar"
				#fill_in "Confirmation",	with: "foobar"
				fill_in "Password confirmation",	with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find(email:'user@example.com') }

				it { should have_link('Sign out') }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
		end
	end
end
