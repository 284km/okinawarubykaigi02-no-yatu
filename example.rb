require 'benchmark_driver'

# Benchmark.driver(output: :markdown) do |x|
# Benchmark.driver(output: :memory) do |x|
Benchmark.driver do |x|
  x.rbenv '2.4.3', '2.5.0'
  x.prelude %{
    ARRAY = [*1..100]

    def fast
      ARRAY[0]
    end

    def slow
      ARRAY.first
    end
  }

  x.report('Array#[0]', %{ fast })
  x.report('Array#first', %{ slow })
end

__END__

warming up..
# benchmark results (i/s)

|             |   2.4.3|   2.5.0|
|:------------|:-------|:-------|
|Array#[0]    | 31.987M| 23.629M|
|Array#first  | 26.173M| 22.935M|


Warming up --------------------------------------
           Array#[0]    13.172M i/s
         Array#first    16.896M i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
           Array#[0]    35.965M     18.037M i/s -     39.516M times in 1.098746s 2.190907s
         Array#first    23.678M     16.861M i/s -     50.689M times in 2.140770s 3.006227s

Comparison:
                        Array#[0]
               2.4.3:  35965038.3 i/s
               2.5.0:  18036567.5 i/s - 1.99x  slower

                      Array#first
               2.4.3:  23677751.9 i/s
               2.5.0:  16861208.8 i/s - 1.40x  slower

