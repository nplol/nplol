require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

	test "should create comment" do
		assert_difference('Comment.count') do
			post :create, { :comment=>{:name => 'NicoP', :text => 'comment1'}, :post_id => 1}
		end
		assert_not_nil assigns(:post)
		assert_redirected_to post_path(assigns(:post)
		assert flash[:notice] == "Comment created"
	end

	test "should list errors" do
		post :create, {:comment=> {:text => 'comment1'}, :post_id => 1}
		assert_template 'posts/show'
	end

end
