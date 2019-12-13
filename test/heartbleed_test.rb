# frozen_string_literal: true
require_relative "test_helper"

SingleCov.covered!

describe Heartbleed do
  it "has a VERSION" do
    Heartbleed::VERSION.must_match /^[\.\da-z]+$/
  end
end
