# frozen_string_literal: true

require_relative '../spec_helper'

describe User, type: :model do
  it { is_expected.to have_many(:topics) }
  it { is_expected.to have_many(:reading_lists) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_format_of(:email).with(:email_address) }

  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_format_of(:password).with(User::VALID_PASSWORD) }
end
