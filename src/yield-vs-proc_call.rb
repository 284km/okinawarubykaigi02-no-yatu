require 'benchmark_driver'
Benchmark.driver do |x|
  x.rbenv '2.4.3', '2.5.0'
  x.prelude %{
    def slow(&block)
      block.call
    end

    def slow2(&block)
      yield
    end

    def slow3(&block)
    end

    def fast
      yield
    end
  }
  x.report 'block.call', %{ slow { 1 + 1 } }
  x.report 'block + yield', %{ slow2 { 1 + 1 } }
  x.report 'block argument', %{ slow3 { 1 + 1 } }
  x.report 'yield', %{ fast { 1 + 1 } }
end

__END__


$ ruby src/yield-vs-proc_call.rb
Warming up --------------------------------------
          block.call     2.674M i/s
       block + yield     3.033M i/s
      block argument     2.293M i/s
               yield    12.830M i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
          block.call     2.672M      2.519M i/s -      8.021M times in 3.001417s 3.183780s
       block + yield     2.594M     11.536M i/s -      9.100M times in 3.507726s 0.788895s
      block argument     3.168M     25.601M i/s -      6.878M times in 2.171074s 0.268673s
               yield    15.509M     17.442M i/s -     38.489M times in 2.481702s 2.206626s

Comparison:
                       block.call
               2.4.3:   2672407.1 i/s
               2.5.0:   2519334.9 i/s - 1.06x  slower

                    block + yield
               2.5.0:  11535556.7 i/s
               2.4.3:   2594371.1 i/s - 4.45x  slower

                   block argument
               2.5.0:  25601281.1 i/s
               2.4.3:   3168189.1 i/s - 8.08x  slower

                            yield
               2.5.0:  17442324.6 i/s
               2.4.3:  15508988.2 i/s - 1.12x  slower

ruby src/yield-vs-proc_call.rb  27.26s user 0.52s system 88% cpu 31.251 total
$

---

$ ruby src/string_match-vs-string_match_question.rb
Warming up --------------------------------------
              match?     5.043M i/s
               match   674.573k i/s
                  =~   796.516k i/s
Calculating -------------------------------------
              match?     3.457M i/s -     15.128M times in 4.376318s (289.29ns/i)
               match   703.578k i/s -      2.024M times in 2.876324s (1.42μs/i)
                  =~   649.987k i/s -      2.390M times in 3.676297s (1.54μs/i)

Comparison:
              match?:   3456778.7 i/s
               match:    703578.2 i/s - 4.91x  slower
                  =~:    649987.2 i/s - 5.32x  slower

ruby src/string_match-vs-string_match_question.rb  14.53s user 0.33s system 83% cpu 17.784 total
$

