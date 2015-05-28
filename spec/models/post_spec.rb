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

  context 'public' do
    let(:post) { create :post}

    it 'sets new posts as public by default' do
      expect(post.public?).to eq(true)
    end
  end
  
  context 'tags' do
    let(:poor_tag_format) { "tag101, tag102, tag103\ntag104, tag105" }
    let(:post)            { Post.first }
    let(:post_with_tags)  { create :post_with_tags }

    before :each do
      FactoryGirl.reload # reload FactoryGirl sequences
      create_list :tag, 5
      create :post
    end
  
    context 'existing tags' do

      it 'adds tags to post without creating new tags' do
        post.tag_list= 'tag1, tag2'
        post.save
        expect(post.tags.length).to eq(2)
        expect(Tag.all.length).to eq(5)
      end

      it 'adds new tas when they do not exist' do
        post.tag_list= 'tag1, tag99'
        post.save
        expect(Tag.all.length).to eq(6)
      end

      it 'correctly updates tags' do
        post_with_tags.tag_list = 'tag1'
        post_with_tags.save
        expect(post_with_tags.tags.length).to eq(1)
      end
    end

    it 'only adds properly formatted tags' do
      # tags are separated by commas.
      post.tag_list = poor_tag_format
      expect(post.tags.length).to eq(4)
      expect(Tag.all.length).to eq(9)
    end

    it 'displays tags appropriately' do
      expect(post_with_tags.tag_list).to eq('tag1, tag2, tag3, tag4, tag5')
    end

  end
end
