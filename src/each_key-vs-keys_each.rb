require 'benchmark_driver'
Benchmark.driver do |x|
  x.prelude %{
    MYSELF = {
      'id' => '@284km',
      'info' => {
        'language' => 'japanese / ruby',
        'from' => 'Tokyo',
        'name' => 'Kazuma Furuhashi',
        'nickname' => '秒速さん / byousokusan',
        'work' => 'https://www.feedforce.jp/',
        'community' => 'asakusarb, shibuyarb, omotesandorb, shinjukurb',
        'organize' => 'railsdm 2018 3/24, 3/25'
      },
      'etc1' => { 'foo' => { 'id' => '1234567', 'name' => '284km', 'first_name' => '284', 'last_name' => 'km', 'link' => 'http://example.com', 'username' => '284km', 'location' => { 'id' => '123456789', 'name' => 'Okinawa' }, 'gender' => 'male', 'email' => 'email@example.com', 'timezone' => -8, 'locale' => 'en_US', 'verified' => true, 'updated_time' => '2011-11-11T06:21:03+0000' } }, 'etc2' => { 'foo' => { 'id' => '1234567', 'name' => '284km', 'first_name' => '284', 'last_name' => 'km', 'link' => 'http://example.com', 'username' => '284km', 'location' => { 'id' => '123456789', 'name' => 'Okinawa' }, 'gender' => 'male', 'email' => 'email@example.com', 'timezone' => -8, 'locale' => 'en_US', 'verified' => true, 'updated_time' => '2011-11-11T06:21:03+0000' } }, 'etc3' => { 'foo' => { 'id' => '1234567', 'name' => '284km', 'first_name' => '284', 'last_name' => 'km', 'link' => 'http://example.com', 'username' => '284km', 'location' => { 'id' => '123456789', 'name' => 'Okinawa' }, 'gender' => 'male', 'email' => 'email@example.com', 'timezone' => -8, 'locale' => 'en_US', 'verified' => true, 'updated_time' => '2011-11-11T06:21:03+0000' } },
    }
    def slow
      MYSELF.keys.each(&:to_sym)
    end

    def fast
      MYSELF.each_key(&:to_sym)
    end
  }
  x.report 'Hash#keys.each', %{ slow }
  x.report 'Hash#each_key',  %{ fast }
end

__END__

$ ruby src/each_key-vs-keys_each.rb
Warming up --------------------------------------
      Hash#keys.each     1.101M i/s
       Hash#each_key     1.174M i/s
Calculating -------------------------------------
                          2.4.3       2.5.0
      Hash#keys.each   884.170k    724.117k i/s -      3.302M times in 3.734351s 4.559761s
       Hash#each_key     1.305M      1.094M i/s -      3.521M times in 2.697019s 3.216897s

Comparison:
                   Hash#keys.each
               2.4.3:    884169.7 i/s
               2.5.0:    724116.9 i/s - 1.22x  slower

                    Hash#each_key
               2.4.3:   1305332.3 i/s
               2.5.0:   1094379.5 i/s - 1.19x  slower

ruby src/each_key-vs-keys_each.rb  16.69s user 0.32s system 87% cpu 19.354 total
$

---

$ ruby src/each_key-vs-keys_each.rb
Warming up --------------------------------------
      Hash#keys.each   772.721k i/s
       Hash#each_key     1.082M i/s
Calculating -------------------------------------
      Hash#keys.each   656.105k i/s -      2.318M times in 3.533221s (1.52μs/i)
       Hash#each_key   633.670k i/s -      3.245M times in 5.120226s (1.58μs/i)

Comparison:
      Hash#keys.each:    656104.7 i/s
       Hash#each_key:    633669.9 i/s - 1.04x  slower

ruby src/each_key-vs-keys_each.rb  8.93s user 0.31s system 68% cpu 13.549 total
$



