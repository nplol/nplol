require 'spec_helper'

describe "listing all posts" do
	it "shows nplol on the index page" do
		visit posts_path
		expect(page).to have_content 'nplol'
	end
end