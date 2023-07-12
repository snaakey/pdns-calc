## DNS Calculator

Do simple mathematical operations using DNS queries.

    $ dig @ns.dus.kyouma.net +short txt 1-a-4-m-50-d-250.calc.emily.cat
    "1.8"
    $ dig +short txt calc.help.emily.cat
    "operators are a (add), s (subtract), m (multiply), and d (divide)."
    "separate tokens with '-' or '.'"

It should work on every DNS server but sometimes it’s buggy. If you don’t get a result try to specify ns.dus.kyouma.net as nameserver.
