# frozen_string_literal: true
class Heartbleed
  class Missed < RuntimeError
  end

  def self.raise_when_missed(interval)
    heartbeat = new(interval)
    heartbeat.start

    begin
      yield heartbeat
    ensure
      heartbeat.stop
    end
  end

  def initialize(interval)
    @interval = interval
    beat
  end

  def start
    mainline = Thread.current

    @thread = Thread.new do
      loop do
        pause = @check_at - now
        if pause <= 0
          mainline.raise Missed
          break
        end
        sleep pause
      end
    end
  end

  def stop
    @thread.kill
    @thread.join
  end

  def beat
    @check_at = now + @interval
  end

  private

  def now
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
