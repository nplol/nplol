require 'rails_helper'

feature 'Liking posts' do

  before :each do
    create_detailed_list :user, 3, names: ['Frank', 'James', 'Timothy']
  end 

  scenario 'listing users who have liked a post', :js => true  do
    post = create :post_with_likes
    visit "/posts/#{post.to_param}"
    find('.attention').trigger(:mouseover)
    expect(page.body).to have_content('Frank')
  end

end
