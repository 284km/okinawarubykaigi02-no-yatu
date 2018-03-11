require 'benchmark_driver'

Benchmark.driver do |x|
  x.rbenv '2.4.3', '2.5.0'
  x.prelude %{
    class Okinawa
      def naha; end
      def method_missing(_method,*args); naha; end
    end

    def fastest
      o = Okinawa.new; o.naha
    end

    def slow
      o = Okinawa.new; o.send(:naha)
    end

    def slowest
      o = Okinawa.new; o.sapporo
    end
  }

  x.report "call", %{ fastest }
  x.report "send", %{ slow }
  x.report "method_missing", %{ slowest }
end

__END__

$ ruby src/call-vs-send-vs-method_missing.rb
Warming up --------------------------------------
                call     2.939M i/s
                send     3.437M i/s
      method_missing     3.835M i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
                call     6.374M      4.518M i/s -      8.817M times in 1.383250s 1.951277s
                send     3.626M      4.752M i/s -     10.312M times in 2.843907s 2.170215s
      method_missing     3.241M      2.868M i/s -     11.505M times in 3.549926s 4.011539s

Comparison:
                             call
               2.4.3:   6373975.8 i/s
               2.5.0:   4518477.9 i/s - 1.41x  slower

                             send
               2.5.0:   4751594.7 i/s
               2.4.3:   3625991.3 i/s - 1.31x  slower

                   method_missing
               2.4.3:   3241008.4 i/s
               2.5.0:   2868061.4 i/s - 1.13x  slower

ruby src/call-vs-send-vs-method_missing.rb  21.38s user 0.43s system 86% cpu 25.347 total
$

---

$ ruby src/call-vs-send-vs-method_missing.rb
Warming up --------------------------------------
                call     4.056M i/s
                send     4.720M i/s
      method_missing     3.222M i/s
Calculating -------------------------------------
                call     6.814M i/s -     12.168M times in 1.785709s (146.76ns/i)
                send     4.384M i/s -     14.160M times in 3.229691s (228.08ns/i)
      method_missing     3.677M i/s -      9.665M times in 2.628486s (271.97ns/i)

Comparison:
                call:   6814012.8 i/s
                send:   4384355.3 i/s - 1.55x  slower
      method_missing:   3676912.5 i/s - 1.85x  slower

ruby src/call-vs-send-vs-method_missing.rb  12.93s user 0.28s system 86% cpu 15.203 total
$

