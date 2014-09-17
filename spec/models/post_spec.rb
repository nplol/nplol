require 'rails_helper'

describe Post do

  context 'Paperclip' do
    let(:post) { create :post }
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
      3.times { create :post }
    end

    it 'finds siblings for a given post' do
      expect(Post.first.next).to_not be_nil
    end

    it 'doesn\'t find non-existant siblings' do
      expect(Post.first.previous).to be_nil
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

end
