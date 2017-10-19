LOA1_PICKER_EXPERIMENT = 'loa1_picker'.freeze

loa1_picker_control_piwik = SelectRoute.new(LOA1_PICKER_EXPERIMENT, 'control', true, 'LEVEL_1')
loa1_picker_variant_radio_account_piwik = SelectRoute.new(LOA1_PICKER_EXPERIMENT, 'variant_radio_account', true, 'LEVEL_1')
loa1_picker_variant_radio_verify_piwik = SelectRoute.new(LOA1_PICKER_EXPERIMENT, 'variant_radio_verify', true, 'LEVEL_1')

loa1_picker_control = SelectRoute.new(LOA1_PICKER_EXPERIMENT, 'control')
loa1_picker_variant_radio_account = SelectRoute.new(LOA1_PICKER_EXPERIMENT, 'variant_radio_account')
loa1_picker_variant_radio_verify = SelectRoute.new(LOA1_PICKER_EXPERIMENT, 'variant_radio_verify')


constraints loa1_picker_control_piwik do
  get 'start', to: 'start#index', as: :start
end

constraints loa1_picker_control do
  get 'choose_a_certified_company', to: 'choose_a_certified_company#index', as: :choose_a_certified_company
  post 'choose_a_certified_company', to: 'choose_a_certified_company#select_idp', as: :choose_a_certified_company_submit

  get 'why_companies', to: 'why_companies#index', as: :why_companies
end

constraints loa1_picker_variant_radio_account_piwik do
  get 'start', to: 'start_variant_radio_account#index', as: :start_loa1
end

constraints loa1_picker_variant_radio_account do
  post 'start', to: 'start_variant_radio_account#request_post', as: :start_loa1

  get 'choose_a_certified_company', to: 'choose_a_certified_company_variant_radio_account#index', as: :choose_a_certified_company
  post 'choose_a_certified_company', to: 'choose_a_certified_company_variant_radio_account#select_idp', as: :choose_a_certified_company_submit

  get 'why_companies', to: 'why_companies_variant_radio_account#index', as: :why_companies
end

constraints loa1_picker_variant_radio_verify_piwik do
  get 'start', to: 'start_variant_radio_verify#index', as: :start_loa1
end

constraints loa1_picker_variant_radio_verify do
  post 'start', to: 'start_variant_radio_verify#request_post', as: :start_loa1

  get 'choose_a_certified_company', to: 'choose_a_certified_company_variant_radio_verify#index', as: :choose_a_certified_company
  post 'choose_a_certified_company', to: 'choose_a_certified_company_variant_radio_verify#select_idp', as: :choose_a_certified_company_submit

  get 'why_companies', to: 'why_companies_variant_radio_verify#index', as: :why_companies
end
