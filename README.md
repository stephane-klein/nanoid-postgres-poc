# PostgreSQL nanoid POC

I wanted to use random ids shorter than [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) in the urls of a web application, so in this repository I wanted to test a 100% PostgreSQL-based implementation of [NanoID](https://github.com/ai/nanoid).

The majority of the code comes from the projects https://github.com/turbo/pg-shortkey/ and https://github.com/viascom/nanoid-postgres

To avoid any risk of `NanoID` collision (you can calculate the probability on [this site]((https://zelark.github.io/nano-id-cc/))), this implementation requires the use of a trigger, which makes the configuration more complicated than generating `UUID` with a simple `uuid_generate_v4()` command.

If you find a simpler method, feel free to create an issue 😉.


```sh
$ docker compose up -d postgres --wait
$ ./scripts/seed.sh
$ ./scripts/fixtures.sh
$ ./scripts/enter-in-pg.sh
postgres=# select id, username from users limit 10;
      id      |  username
--------------+-------------
 MmkinO7ngxuX | username001
 ucap5BTMh6Wl | username002
 tI2qIbFrPdeH | username003
 3R7XLgeXbK4u | username004
 P1l4R8HikKAF | username005
 jQwE5FEjhHLL | username006
 wu3cwgMHm7EW | username007
 qIGC2UldJTPB | username008
 N6EI33QTFiJr | username009
 SvqpppADLdJn | username010
(10 rows)
(10 rows)
```
