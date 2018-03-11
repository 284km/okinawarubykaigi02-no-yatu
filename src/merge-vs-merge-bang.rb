require 'benchmark_driver'
Benchmark.driver do |x|
  x.prelude %{
    ENUM = (1..100)
    def slow
      ENUM.inject({}) do |h, e|
        h.merge(e => e)
      end
    end

    def fast
      ENUM.inject({}) do |h, e|
        h.merge!(e => e)
      end
    end
  }
  x.report 'Hash#merge', %{ slow }
  x.report 'Hash#merge!', %{ fast }
end

__END__

$ ruby src/merge-vs-merge-bang.rb
Warming up --------------------------------------
          Hash#merge     2.345k i/s
         Hash#merge!    13.108k i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
          Hash#merge     2.059k      6.035k i/s -      7.034k times in 3.416088s 1.165548s
         Hash#merge!    10.889k     10.225k i/s -     39.323k times in 3.611119s 3.845667s

Comparison:
                       Hash#merge
               2.5.0:      6034.9 i/s
               2.4.3:      2059.1 i/s - 2.93x  slower

                      Hash#merge!
               2.4.3:     10889.4 i/s
               2.5.0:     10225.3 i/s - 1.06x  slower

ruby src/merge-vs-merge-bang.rb  13.82s user 0.56s system 85% cpu 16.855 total

---

$ ruby src/merge-vs-merge-bang.rb
Warming up --------------------------------------
          Hash#merge     2.011k i/s
         Hash#merge!     5.645k i/s
Calculating -------------------------------------
          Hash#merge     3.369k i/s -      6.031k times in 1.790057s (296.81μs/i)
         Hash#merge!     7.337k i/s -     16.936k times in 2.308151s (136.29μs/i)

Comparison:
         Hash#merge!:      7337.5 i/s
          Hash#merge:      3369.2 i/s - 2.18x  slower

ruby src/merge-vs-merge-bang.rb  5.00s user 0.32s system 57% cpu 9.265 total
$

