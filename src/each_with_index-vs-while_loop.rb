require 'benchmark_driver'
Benchmark.driver do |x|
  x.prelude %{
    ARRAY = [*1..100]
    def fast
      index = 0
      while index < ARRAY.size
        ARRAY[index] + index
        index += 1
      end
      ARRAY
    end

    def slow
      ARRAY.each_with_index do |number, index|
        number + index
      end
    end
  }
  x.report "While Loop", %{ fast }
  x.report "each_with_index", %{ slow }
end

__END__

$ ruby src/each_with_index-vs-while_loop.rb
Warming up --------------------------------------
          While Loop   202.305k i/s
     each_with_index   118.461k i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
          While Loop   217.263k    202.542k i/s -    606.916k times in 2.793459s 2.996498s
     each_with_index    90.912k    128.604k i/s -    355.383k times in 3.909093s 2.763389s

Comparison:
                       While Loop
               2.4.3:    217263.3 i/s
               2.5.0:    202541.8 i/s - 1.07x  slower

                  each_with_index
               2.5.0:    128604.0 i/s
               2.4.3:     90911.9 i/s - 1.41x  slower

ruby src/each_with_index-vs-while_loop.rb  14.56s user 0.32s system 85% cpu 17.361 total
$

---

$ ruby src/each_with_index-vs-while_loop.rb
Warming up --------------------------------------
          While Loop   132.436k i/s
     each_with_index    97.521k i/s
Calculating -------------------------------------
          While Loop   125.523k i/s -    397.307k times in 3.165208s (7.97μs/i)
     each_with_index    63.501k i/s -    292.563k times in 4.607203s (15.75μs/i)

Comparison:
          While Loop:    125523.2 i/s
     each_with_index:     63501.2 i/s - 1.98x  slower

ruby src/each_with_index-vs-while_loop.rb  7.89s user 0.32s system 56% cpu 14.641 total
$
