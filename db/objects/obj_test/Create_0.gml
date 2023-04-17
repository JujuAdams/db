db_a = db_create();
db_write(db_a, 10, "test", 0, "test 2");
db_save(db_a, "a.json", true, true);

db_b = db_load("a.json");
show_debug_message(db_read(db_b, 0, "test", 0, "test 2"));