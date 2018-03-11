require 'benchmark_driver'

Benchmark.driver do |x|
  # x.rbenv '2.4.3', '2.5.0'
  x.prelude %{
    # Allocates new string over and over again
    def without_freeze
      "freeze or not freeze"
    end

    # Keeps and reuses shared string
    def with_feeze
      "freeze or not freeze".freeze
    end
  }
  x.report "Without Freeze", %{ without_freeze }
  x.report "With Freeze", %{ with_feeze }
end

__END__

$ ruby src/frozen_string-vs-mutable.rb
Warming up --------------------------------------
      Without Freeze    10.535M i/s
         With Freeze    25.783M i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
      Without Freeze    15.336M     17.508M i/s -     31.604M times in 2.060804s 1.805167s
         With Freeze    43.809M     35.063M i/s -     77.349M times in 1.765612s 2.206024s

Comparison:
                   Without Freeze
               2.5.0:  17507719.2 i/s
               2.4.3:  15335935.4 i/s - 1.14x  slower

                      With Freeze
               2.4.3:  43808565.0 i/s
               2.5.0:  35062595.9 i/s - 1.25x  slower

ruby src/frozen_string-vs-mutable.rb  18.02s user 0.33s system 89% cpu 20.591 total
$

---

$ ruby src/frozen_string-vs-mutable.rb
Warming up --------------------------------------
      Without Freeze     3.493M i/s
         With Freeze    21.705M i/s
Calculating -------------------------------------
      Without Freeze    15.527M i/s -     10.478M times in 0.674811s (64.40ns/i)
         With Freeze    41.407M i/s -     65.115M times in 1.572554s (24.15ns/i)

Comparison:
         With Freeze:  41407136.4 i/s
      Without Freeze:  15527091.3 i/s - 2.67x  slower

ruby src/frozen_string-vs-mutable.rb  7.26s user 0.21s system 78% cpu 9.487 total
$

