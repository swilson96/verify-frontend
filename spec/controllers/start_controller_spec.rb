require 'rails_helper'
require 'controller_helper'
require 'api_test_helper'
require 'piwik_test_helper'

describe StartController do
  context 'loa1' do
    before(:each) do
      stub_piwik_request_with_rp_and_loa({ 'action_name' => 'The user has reached the start page' }, 'LEVEL_1')
      set_session_and_cookies_with_loa('LEVEL_1')
    end

    it 'renders LOA1 start page if service is level 1' do
      get :index, params: { locale: 'en' }
      expect(subject).to render_template(:start_loa1)
    end

    describe 'navigation from start page' do
      it 'will redirect to sign in page when selection is sign in' do
        stub_piwik_request = stub_piwik_journey_type_request(
          'SIGN_IN',
          'The No option was selected on the introduction page',
          'LEVEL_1'
        )
        get :sign_in, params: { locale: 'en' }
        expect(subject).to redirect_to('/sign-in')
        expect(stub_piwik_request).to have_been_made.once
      end

      it 'will redirect to about page when selection is registration' do
        stub_piwik_request = stub_piwik_journey_type_request(
          'REGISTRATION',
          'The Yes option was selected on the start page',
          'LEVEL_1'
        )
        get :register, params: { locale: 'en' }
        expect(subject).to redirect_to('/choose-a-certified-company')
        expect(stub_piwik_request).to have_been_made.once
      end
    end
  end

  context 'loa2' do
    before(:each) do
      stub_piwik_request_with_rp_and_loa('action_name' => 'The user has reached the start page')
      set_session_and_cookies_with_loa('LEVEL_2')
    end

    it 'renders LOA2 start page if service is level 2' do
      get :index, params: { locale: 'en' }
      expect(a_request_to_piwik).to have_been_made
      expect(subject).to render_template(:start_loa2)
    end

    context 'when form is valid' do
      it 'will redirect to sign in page when selection is false' do
        stub_piwik_request = stub_piwik_journey_type_request(
          'SIGN_IN',
          'The No option was selected on the introduction page',
          'LEVEL_2'
        )
        post :request_post, params: { locale: 'en', start_form: { selection: false } }
        expect(subject).to redirect_to('/sign-in')
        expect(stub_piwik_request).to have_been_made.once
      end

      it 'will redirect to about page when selection is true' do
        stub_piwik_request = stub_piwik_journey_type_request(
          'REGISTRATION',
          'The Yes option was selected on the start page',
          'LEVEL_2'
        )
        post :request_post, params: { locale: 'en', start_form: { selection: true } }
        expect(subject).to redirect_to('/about')
        expect(stub_piwik_request).to have_been_made.once
      end
    end

    context 'when form is invalid' do
      it 'renders itself' do
        post :request_post, params: { locale: 'en' }
        expect(subject).to render_template(:start_loa2)
        expect(flash[:errors]).not_to be_empty
      end
    end
  end
end
