require 'benchmark_driver'
Benchmark.driver do |x|
  x.prelude %{
    def fast
      "aaacolorzzz".match?(/color/)
    end

    def slow
      "aaacolorzzz".match(/color/)
    end

    def slow2
      "aaacolorzzz" =~ /color/
    end
  }
  x.report('match?', %{ fast })
  x.report('match', %{ slow })
  x.report('=~', %{ slow2 })
end

__END__

$ ruby src/string_match-vs-string_match_question.rb
Warming up --------------------------------------
              match?     4.780M i/s
               match   807.807k i/s
                  =~   806.411k i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
              match?     5.600M      6.004M i/s -     14.340M times in 2.560826s 2.388466s
               match   893.432k    793.038k i/s -      2.423M times in 2.712485s 3.055873s
                  =~   794.992k    983.313k i/s -      2.419M times in 3.043091s 2.460286s

Comparison:
                           match?
               2.5.0:   6004043.2 i/s
               2.4.3:   5599932.6 i/s - 1.07x  slower

                            match
               2.4.3:    893432.4 i/s
               2.5.0:    793037.5 i/s - 1.13x  slower

                               =~
               2.5.0:    983313.3 i/s
               2.4.3:    794991.7 i/s - 1.24x  slower

ruby src/string_match-vs-string_match_question.rb  21.20s user 0.41s system 88% cpu 24.390 total
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

