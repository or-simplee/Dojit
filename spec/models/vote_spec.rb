require 'rails_helper'

describe Vote do

  include TestFactories
  
  describe "validations" do

    before do
      @v1 = Vote.new(value: 1)
      @v2 = Vote.new(value: -1)
      @v3 = Vote.new(value: 2)
    end

    describe 'value validation' do
      it "only allows -1 or 1 as values" do
        expect( @v1.valid? && @v2.valid? && !@v3.valid? ).to eq(true)
      end
    end
  end

  describe 'after_save' do
    it "calls `Post#update_rank` after save" do
      post = associated_post({})
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end
end