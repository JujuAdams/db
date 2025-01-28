db_a = db_create();
db_write(db_a, 10, "test", 0, "test 2");
db_write(db_a, object_index, "test obj reference");
db_save(db_a, "a.json");

db_b = db_load("a.json");
show_debug_message(db_read(db_b, 0, "test", 0, "test 2"));
show_debug_message(object_get_name(handle_parse(db_read(db_b, undefined, "test obj reference"))));