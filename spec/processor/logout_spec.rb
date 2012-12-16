require 'spec_helper'

describe CASinoCore::Processor::Logout do
  describe '#process' do
    let(:listener) { Object.new }
    let(:processor) { described_class.new(listener) }
    let(:cookies) { { tgt: tgt } }
    let(:url) { nil }
    let(:params) { { :url => url } unless url.nil? }

    before(:each) do
      listener.stub(:user_logged_out)
    end

    context 'with an existing ticket-granting ticket' do
      let(:ticket_granting_ticket) {
        CASinoCore::Model::TicketGrantingTicket.create!({
          ticket: 'TGC-HXdkW233TsRtiqYGq4b8U7',
          username: 'test',
          extra_attributes: nil,
          user_agent: 'TestBrowser 1.0'
        })
      }
      let(:tgt) { ticket_granting_ticket.ticket }

      it 'calls the #process method of SessionDestroyer' do
        CASinoCore::Processor::SessionDestroyer.any_instance.should_receive(:process).with(tgt)
        processor.process(params, cookies)
      end

      it 'calls the #user_logged_out method on the listener' do
        listener.should_receive(:user_logged_out).with(nil)
        processor.process(params, cookies)
      end

      context 'with an URL' do
        let(:url) { 'http://www.example.com' }

        it 'calls the #user_logged_out method on the listener and passes the URL' do
          listener.should_receive(:user_logged_out).with(url)
          processor.process(params, cookies)
        end
      end
    end

    context 'with an invlaid ticket-granting ticket' do
      let(:tgt) { 'TGT-lalala' }

      it 'calls the #user_logged_out method on the listener' do
        listener.should_receive(:user_logged_out).with(nil)
        processor.process(params, cookies)
      end
    end
  end
end