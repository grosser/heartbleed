Tiny/Efficient/Simple library that stops your code when it gets stuck

 - Runs on main thread
 - Only check once per `interval`
 - Does not leave threads behind
 - uses `CLOCK_MONOTONIC`

Install
=======

```Bash
gem install heartbleed
```

Usage
=====

```Ruby
# stop execution when stuck
Heartbleed.raise_when_missed 0.1 do |heart|
  10.times do |i|
    puts i
    if i == 4
      sleep 0.2
      puts "Never gets here" 
    end
    heart.beat
  end
rescue Heartbleed::Missed
  puts "I'm dead now"
end

# nothing happens when code stays active
Heartbleed.raise_when_missed 0.1 do |heart|
  5.times do
    puts "Run"
    sleep 0.05
    heart.beat
  end 
end
```

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/heartbleed.svg)](https://travis-ci.org/grosser/heartbleed)
[![coverage](https://img.shields.io/badge/coverage-100%25-success.svg)](https://github.com/grosser/single_cov)
