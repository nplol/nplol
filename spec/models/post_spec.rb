require 'rails_helper'

describe Post do

  context 'Paperclip' do
    let(:post) { build :post }
    let(:invalid_image) { File.new("#{Rails.root}/spec/files/invalid.mp4") }
    let(:valid_image) { File.new("#{Rails.root}/spec/files/valid_image.png") }
    let(:valid_path) { "#{Rails.root}/spec/public/valid_image.png" }

    it 'doesn\'t upload an invalid image' do
      expect{ post.update_attributes!(image: invalid_image) }.to raise_error
      expect(post.errors.messages[:image]).to_not be_empty
    end

    it 'uploads a valid image' do
      expect{ post.update_attributes!(image: valid_image) }.to_not raise_error
      expect(post.image.path).to eq(valid_path)
      expect(post.image.url(:thumb)).to_not be_nil
      expect(post.image.url(:medium)).to_not be_nil
      expect(post.image.url(:large)).to_not be_nil
    end

    # remove paperclip generated files.
    after :all do
      FileUtils.rm_rf("#{Rails.root}/spec/public")
    end
  end

  context 'Siblings' do
    before :all do
      create_list :post, 3
    end

    it 'finds siblings for a given post' do
      expect(Post.first.previous).to_not be_nil
    end

    it 'doesn\'t find non-existant siblings' do
      expect(Post.first.next).to be_nil
    end

    it 'finds both siblings when present' do
      expect(Post.second.next).to_not be_nil
      expect(Post.second.previous).to_not be_nil
    end

  end

  context 'public' do
    let(:post) { create :post}

    it 'sets new posts as public by default' do
      expect(post.public?).to eq(true)
    end
  end
  
  context 'tags' do
    let(:tags) { Tag.all }
    let(:poor_tag_format) { "tag101, tag102, tag103\ntag104, tag105" }

    before :all do
      create_list :tag, 5
    end

    before :each do
      @post = build :post
    end

    #after :each do
      #post.tags.destroy_all
      #if tags.length != 3 # i.e. tags has been modified
        #tags = [ Tag.find(1).name, Tag.find(2).name, Tag.find(3).name]
      #end
    #end

    it 'adds existing tags to a post' do
      @post.tags << tags
      @post.save!
      expect(@post.tags).to eq(tags)
    end

    #it 'adds new tags' do
      #tags << 'tag99'
      #put :update, id: post.to_param, post: { tag_list: tags.join(', ') }
      #expect(Tag.all.length).to eq(6)
    #end

    #it 'only adds properly formatted tags' do
      #put :update, id: post.to_param, post: { tag_list: poor_tag_format }
      ## tags are separated by commas.
      #expect(post.tags.length).to eq(3)
      #expect(Tag.all.length).to eq(8)
    #end

    #it 'deletes tags from a post' do
      #new_tags = tags.pop
      #put :update, id: post.to_param, post: { tag_list: new_tags }
      #expect(assigns(:post).tags.length).to eq(1)
    #end

  end
end
