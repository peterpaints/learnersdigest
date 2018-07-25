# frozen_string_literal: true

require_relative '../spec_helper'

describe Topic, type: :model do
  it { is_expected.to have_many(:users) }

  it { is_expected.to have_property(:title) }
end
