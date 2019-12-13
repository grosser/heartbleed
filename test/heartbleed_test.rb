# frozen_string_literal: true
require_relative "test_helper"

SingleCov.covered!

describe Heartbleed do
  it "has a VERSION" do
    Heartbleed::VERSION.must_match /^[\.\da-z]+$/
  end

  describe "#raise_when_missed" do
    it "executes and finishes" do
      a = 0
      Heartbleed.raise_when_missed(1) { a = 1 }
      a.must_equal 1
    end

    it "executes on the current thread to avoid thread var issues" do
      Thread.current[:foo] = 1
      a = 0
      Heartbleed.raise_when_missed(1) { a = Thread.current[:foo] }
      a.must_equal 1
    end

    it "stops when heartbeat is missed" do
      a = 0
      Heartbleed.raise_when_missed(0.05) do
        begin
          sleep 0.1
          a = 1
        rescue Heartbleed::Missed
          a = 2
        end
      end
      a.must_equal 2
    end

    it "continues when heartbeat is passed" do
      a = 0
      Heartbleed.raise_when_missed(0.05) do |heart|
        3.times do
          sleep 0.04
          heart.beat
        end
        a = 1
      end
      a.must_equal 1
    end
  end
end
