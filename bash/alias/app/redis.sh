redis_flushall () {
    redis-cli FLUSHALL
}
redis_local () {
    redis-server --bind 0.0.0.0 --protected-mode no
}
