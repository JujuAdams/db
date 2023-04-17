db_a = db_create();
db_write(db_a, 10, "test", 0, "test 2");
db_save(db_a, "a.json", true, true);