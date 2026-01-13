db_a = db_create();
db_write(db_a, 10, "test", 0, "test 2");
db_write(db_a, object_index, "test obj reference");
db_debug_save(db_a, "a.json");

db_b = db_debug_load("a.json");
show_debug_message(db_read(db_b, 0, "test", 0, "test 2"));
show_debug_message(object_get_name(handle_parse(db_read(db_b, undefined, "test obj reference"))));

db_c = db_create();
db_write(db_c, { a: 0 }, "test");
db_write(db_c, 1, "test", "a");
db_write(db_c, 2, "test", "b");
db_patch(db_c, { c: [3, 3] }, "test");
db_patch(db_c, [undefined, 4], "test", "c");
show_debug_message(db_get_raw_data(db_c));

db_d = db_create();
db_write(db_d, 1, "a");
db_write(db_d, 2, "b");
show_debug_message(db_get_debug_string(db_d));