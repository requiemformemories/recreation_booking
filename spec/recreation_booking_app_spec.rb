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

  context 'GET to /infomation/taipingshan' do
    let(:params) { nil }

    before do
      get '/infomation/taipingshan', params
    end

    context 'when `village` and `room_type_id` are not provided' do
      let(:village_keys) { JSON.parse(subject.body).keys }
      it { is_expected.to be_ok }
      it { expect(village_keys).to eq(%w[01 02]) }
    end

    context 'when `village` is provided' do
      let(:params) { { village: '02' } }
      let(:room_type_id_keys) { JSON.parse(subject.body)['rooms'].keys }

      it { is_expected.to be_ok }
      it { expect(room_type_id_keys).to eq(%w[18 20 10]) }
    end

    context 'when `village` and `room_type_id` are provided' do
      let(:params) { { village: '02', room_type_id: '10' } }
      let(:room_type_id_name) { JSON.parse(subject.body)['name'] }

      it { is_expected.to be_ok }
      it { expect(room_type_id_name).to eq('翠峰山屋八人團體房') }
    end
  end

  context 'GET to /calendar/taipingshan' do
    let(:params) { nil }

    before do
      get '/calendars/taipingshan', params
    end

    context 'when no params provided' do
      it { is_expected.not_to be_ok }
    end

    context 'when `village` and `room_type_id` params provide' do
      let(:params) { { village: '02', room_type_id: '10' } }

      it { is_expected.to be_ok }
    end
  end
end
