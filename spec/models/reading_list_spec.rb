# frozen_string_literal: true

require_relative '../spec_helper'

describe ReadingList, type: :model do
  it { is_expected.to have_many(:articles) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_property(:created_at) }
  it { is_expected.to have_property(:updated_at) }
end
