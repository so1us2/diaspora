require 'spec_helper'

describe Conversation do
  before do
    @user1 = alice
  end

  describe 'serialization' do
    before do
      @create_hash = { :participant_ids => [@user1.contacts.first.person.id, @user1.person.id],
      :subject => "cool stuff" }
      @cnv = Conversation.new(@create_hash)
      @message = Message.new(:author => @user1.person, :text => "stuff")
      @cnv.messages << @message
      @xml = @cnv.to_diaspora_xml
    end

    it 'serializes the message' do
      @xml.gsub(/\s/, '').should include(@message.to_xml.to_s.gsub(/\s/, ''))
    end

    it 'serializes the participants' do
      @create_hash[:participant_ids].each{|id|
        @xml.should include(Person.find(id).diaspora_handle)
      }
    end

    it 'serializes the created_at time' do
      @xml.should include(@message.created_at.to_s)
    end
  end

  describe "#subscribers?" do
    it 'returns the recipients for the post owner' do

    end

    it 'returns the author for any other user' do

    end
  end
end
