# frozen_string_literal: true

require_relative '../spec_helper'

describe Article, type: :model do
  it { is_expected.to belong_to(:reading_list) }

  it { is_expected.to have_property(:title) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:url) }
end
