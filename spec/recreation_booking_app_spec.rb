# frozen_string_literal: true

require 'spec_helper'
require_relative '../recreation_booking_app'

describe RecreationBookingApp do
  subject { last_response }

  let(:app) { described_class.new }

  context 'GET to /' do
    before do
      get '/'
    end

    it { is_expected.to be_ok }
  end

  context 'GET to /calendar/taipingshan' do
    let(:params) { nil }

    before do
      get '/calendars/taipingshan', params
    end

    context 'when no params provide' do
      it { is_expected.not_to be_ok }
    end

    context 'when `village` and `room_type_id` params provide' do
      let(:params) { { village: '01', room_type_id: '10' } }

      it { is_expected.to be_ok }
    end
  end
end
