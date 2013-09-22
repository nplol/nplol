require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
  	get :new
  	assert_response :success
  	assert_not_nil assigns(:post)
  end

  test "should create post" do
  	assert_difference('Post.count') do
    	post :create, post: {title: 'Some title', content: 'some content'}
  	end

  	assert_redirected_to post_path(assigns(:post))
    assert flash[:notice] = "Post created"
  end

  test "should get edit" do
    get(:edit, {'id' => 1})
    assert_response :success
    assert_not_nil assigns(:post)
  end

end
