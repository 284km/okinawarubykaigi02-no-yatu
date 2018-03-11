require 'benchmark_driver'
Benchmark.driver do |x|
  x.prelude %{
    PACKED = "ABC"
    def fast
      PACKED.unpack1("C*")
    end

    def slow
      PACKED.unpack("C*").first
    end
  }
  x.report 'unpack1', %{ fast }
  x.report 'unpack.first', %{ slow }
end

__END__

